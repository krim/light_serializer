# frozen_string_literal: true

require 'oj'
require 'dry-types'
require 'dry-struct'
require 'active_support/concern'
require 'active_support/core_ext/module/delegation'
require_relative 'attributes'

module LightSerializer
  module Types
    include ::Dry::Types.module

    class NestedObject
      def self.serialize_by(serializer)
        Types::Hash.schema(serializer.attributes)
      end
    end

    class NestedObjects
      def self.each_serialize_by(serializer)
        Types.Array(Types::Hash.schema(serializer.attributes))
      end
    end
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
    end

    def klass_attributes
      self.class.attributes_to_serialize
    end

    def structed_object
      serialization_klass.new(Attributes.prepare(object))
    end
  end
end
