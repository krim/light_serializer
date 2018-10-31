# frozen_string_literal: true

require 'oj'
require 'dry-types'
require 'dry-struct'
require_relative 'validator'
require_relative 'hashed_object'

module LightSerializer
  module Types
    include Dry::Types.module
  end

  module Serialization
    attr_reader :object

    def self.included(base)
      base.extend(ClassAttributes)
    end

    module ClassAttributes
      def attributes(attributes_with_types = {})
        return @attributes if attributes_with_types.empty?

        @attributes = @attributes ? @attributes.merge(attributes_with_types) : attributes_with_types
      end

      def light_serializer?
        true
      end

      def validator
        Validator.get(attributes)
      end

      def inherited(subclass)
        subclass.attributes(attributes)
        super(subclass)
      end
    end

    def initialize(object)
      @object = object
    end

    def to_json
      Oj.dump(to_hash, mode: :compat)
    end

    def to_hash
      validated_object.to_hash
    end

    private

    def validated_object
      self.class.validator.new(hashed_object)
    end

    def hashed_object
      HashedObject.get(object, self)
    end
  end
end
