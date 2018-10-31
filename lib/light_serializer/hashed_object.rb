# frozen_string_literal: true

module LightSerializer
  class HashedObject
    attr_reader :object, :serializer

    def self.get(*args)
      new(*args).get
    end

    def initialize(object, serializer)
      @object = object
      @serializer = serializer
    end

    def get
      transform_to_hash
    end

    private

    def transform_to_hash
      serializer.class.attributes.each_with_object({}) do |attribute, result|
        obtain_values(attribute, object, result)
      end
    end

    def obtain_values(attribute, object, result)
      if attribute.is_a?(Hash)
        values_from_nested_resource(attribute, object, result)
      else
        value = obtain_value(object, attribute)

        result[attribute] = if value.is_a?(Array)
          values_from_for_array(attribute, value, result)
        else
          value
        end
      end
    end

    def obtain_value(object, attribute)
      if serializer.respond_to?(attribute)
        serializer.public_send(attribute)
      elsif object.respond_to?(attribute)
        object.public_send(attribute)
      else
        object
      end
    end

    def values_from_nested_resource(attribute, object, result)
      attribute_name = attribute.keys.last
      nested_serializer = attribute.values.last
      value = obtain_value(object, attribute_name)
      result[attribute_name] = nested_serializer.new(value).to_hash
    end

    def values_from_for_array(attribute, value, result)
      value.map { |entity| obtain_values(attribute, entity, result) }
    end
  end
end
