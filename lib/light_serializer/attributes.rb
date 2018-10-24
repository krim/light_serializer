# frozen_string_literal: true

module LightSerializer
  class Attributes
    def self.prepare(object)
      new.prepare(object)
    end

    # :reek:ManualDispatch
    # :reek:FeatureEnvy
    def prepare(object)
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
        prepare(value.to_h)
      else
        value
      end
    end

    def values_from_for_array(value)
      value.map { |entity| prepare(entity) }
    end
  end
end
