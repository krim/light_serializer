# frozen_string_literal: true

module LightSerializer
  class HashedObject
    include Helpers::WithCustomRoot

    attr_reader :raw_object, :serializer

    def self.get(*args)
      new(*args).get
    end

    def initialize(raw_object, serializer)
      @raw_object = raw_object
      @serializer = serializer
    end

    def get
      with_custom_root(serializer.root) { transform_to_hash(raw_object) }
    end

    private

    def transform_to_hash(object)
      serializer.class.attributes.each_with_object({}) do |attribute, result|
        obtain_values(attribute, object, result)
      end
    end

    def obtain_values(attribute, object, result)
      if attribute.is_a?(Hash)
        values_from_nested_resource(attribute, object, result)
      else
        values_from_current_resource(attribute, object, result)
      end
    end

    def values_from_nested_resource(attributes, object, result)
      attributes.each do |attribute_name, nested_serializer|
        value = obtain_value(object, attribute_name)
        result[attribute_name] = hashed_nested_resource(value, nested_serializer)
      end
    end

    def hashed_nested_resource(value, nested_serializer)
      return hashed_entity(value, nested_serializer) unless can_be_enumerated?(value)

      value.each_with_object(nested_serializer).map { |entity, serializer| hashed_entity(entity, serializer) }
    end

    def can_be_enumerated?(value)
      value.is_a?(Enumerable) || active_record_relation?(value)
    end

    def active_record_relation?(object)
      defined?(ActiveRecord::Relation) && object.is_a?(ActiveRecord::Relation)
    end

    def hashed_entity(entity, nested_serializer)
      nested_serializer.new(entity, context: serializer.context).to_hash
    end

    def values_from_current_resource(attribute, object, result)
      value = obtain_value(object, attribute)

      result[attribute] = if value.is_a?(Array)
        values_from_for_array(attribute, value, result)
      else
        value
      end
    end

    # :reek:ManualDispatch
    def obtain_value(object, attribute)
      if serializer.respond_to?(attribute)
        serializer.public_send(attribute)
      elsif object.respond_to?(attribute)
        object.public_send(attribute)
      else
        object
      end
    end

    def values_from_for_array(attribute, value, result)
      value.map { |entity| entity.is_a?(Hash) ? entity : obtain_values(attribute, entity, result) }
    end
  end
end
