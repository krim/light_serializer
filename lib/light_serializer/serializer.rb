# frozen_string_literal: true

require 'oj'
require 'dry-struct'

module LightSerializer
  module Types
    include Dry::Types.module
  end

  class Serializer < Dry::Struct
    class << self
      attr_reader :object_to_serialize

      def new(object)
        @object_to_serialize = object
        hashed_object = transform_to_hash(object_to_serialize)
        super(hashed_object)
      end

      def transform_to_hash(object)
        schema.each_with_object({}) do |(key, type), result|
          obtain_values(key, type, object, result)
        end
      end

      def obtain_values(key, type, object, result)
        value = obtain_value(object, key)

        result[key] = if value.is_a?(Array)
          values_from_for_array(key, type, value, result)
        elsif nested_serializer?(type)
          type.new(value)
        else
          value
        end
      end

      def values_from_for_array(key, type, value, result)
        value.map { |entity| obtain_values(key, type.options[:member], entity, result) }
      end

      def obtain_value(object, key)
        if object.respond_to?(key)
          object.public_send(key)
        elsif respond_to?(key)
          public_send(key)
        else
          object
        end
      end

      def nested_serializer?(type)
        type.respond_to?(:ancestors) && type.ancestors.include?(LightSerializer::Serializer)
      end
    end

    def to_json
      Oj.dump(to_hash, mode: :compat)
    end
  end
end
