# frozen_string_literal: true

module LightSerializer
  class Attributes
    attr_reader :serialization_klass, :object

    def initialize(serialization_klass, object)
      @serialization_klass = serialization_klass
      @object = object
    end

    def self.prepare(serialization_klass, object)
      new(serialization_klass, object).prepare
    end

    def prepare
      attributes_for(object)
    end

    # :reek:ManualDispatch
    # :reek:FeatureEnvy
    def attributes_for(object)
      return object unless object.respond_to?(:to_h)

      object.to_h.transform_values(&method(:value_to_hash))
    end

    private

    # :reek:ManualDispatch
    # :reek:FeatureEnvy
    def value_to_hash(value)
      if value.is_a?(Array)
        values_from_for_array(value)
      elsif value.respond_to?(:to_h)
        attributes_for(value.to_h)
      else
        value
      end
    end

    def values_from_for_array(value)
      value.map { |entity| attributes_for(entity) }
    end

    # :reek:ManualDispatch
    def custom_attributes
      serialization_klass.attribute_names.each_with_object({}) do |attr, result|
        result[attr] = public_send(attr) if respond_to?(attr)
      end
    end
  end
end
