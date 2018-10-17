# frozen_string_literal: true

require 'oj'
require 'dry-types'
require 'dry-struct'

module LightSerializer
  module Types
    include ::Dry::Types.module
  end

  class SerializationObject < Dry::Struct
  end

  class Serialization
    attr_reader :object

    def self.attributes(**attrs)
      SerializationObject.attributes(**attrs)
    end

    def initialize(object)
      @object = object
    end

    def to_json
      structed_object.to_hash
    end

    private

    def structed_object
      SerializationObject.new(object_attributes)
    end

    def object_attributes
      SerializationObject.attribute_names.each_with_object({}) do |name, result|
        result[name] = object.public_send(name)
      end
    end
  end
end
