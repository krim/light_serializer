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
      serializer.class.attributes.each_with_object({}) do |(key, type), result|
        obtain_values(key, type, object, result)
      end
    end

    def obtain_values(key, type, object, result)
      value = obtain_value(object, key)

      result[key] = if value.is_a?(Array)
        values_from_for_array(key, type, value, result)
      elsif type.respond_to?(:light_serializer?)
        type.new(value).to_hash
      else
        value
      end
    end

    def obtain_value(object, key)
      if serializer.respond_to?(key)
        serializer.public_send(key)
      elsif object.respond_to?(key)
        object.public_send(key)
      else
        object
      end
    end

    def values_from_for_array(key, type, value, result)
      value.map { |entity| obtain_values(key, type.member, entity, result) }
    end
  end
end
