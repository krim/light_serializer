# frozen_string_literal: true

require 'oj'
require 'dry-types'
require 'dry-struct'
require 'active_support/concern'
require 'active_support/core_ext/module/delegation'

module LightSerializer
  module Types
    include ::Dry::Types.module
  end

  # :reek:ModuleInitialize
  module Serialization
    extend ActiveSupport::Concern

    class_methods do
      # :reek:Attribute
      attr_accessor :attributes_to_serialize

      def attributes(**attrs)
        self.attributes_to_serialize = attributes_to_serialize ? attributes_to_serialize.merge(attrs) : attrs
      end

      def inherited(subclass)
        super(subclass)
        subclass.attributes_to_serialize = attributes_to_serialize.dup if attributes_to_serialize.present?
      end
    end

    attr_reader :object, :serialization_klass

    delegate :to_hash, to: :structed_object

    def initialize(object)
      @object = object
      @serialization_klass = Class.new(Dry::Struct)

      prepare_attributes
    end

    def to_json
      Oj.dump(to_hash, mode: :compat)
    end

    private

    def prepare_attributes
      klass_attributes.each do |key, type|
        serialization_klass.attribute(key, type)
      end

      nested_object_attributes.each do |key, _type|
        serialization_klass.attribute(key, Types::Hash | Types::Array)
      end
    end

    def nested_object_attributes
      self.class.attributes_to_serialize.reject { |_key, type| dry_klass?(type) }
    end

    def klass_attributes
      self.class.attributes_to_serialize.select { |_key, type| dry_klass?(type) }
    end

    def dry_klass?(type)
      type.class.name.start_with?('Dry::Types::')
    end

    def structed_object
      serialization_klass.new(object_attributes)
    end

    def object_attributes
      current_attributes.merge(nested_attributes)
    end

    def current_attributes
      klass_attributes.each_with_object({}) do |(name, _klass), result|
        result[name] = object.public_send(name)
      end
    end

    def nested_attributes
      nested_object_attributes.each_with_object({}) do |(name, klass), result|
        result[name] = klass.new(object.public_send(name)).to_hash
      end
    end
  end
end
