# frozen_string_literal: true

module LightSerializer
  class Validator
    attr_reader :attributes

    def self.get(*args)
      new(*args).get
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def get
      prepare_validator
    end

    private

    def prepare_validator
      Class.new(Dry::Struct).tap do |validator|
        attributes.each { |key, type| validator.attribute(key, obtain_type(type)) }
      end
    end

    def obtain_type(type)
      if type.respond_to?(:primitive) && type.primitive == Array
        type.of(obtain_type(type.member))
      elsif type.respond_to?(:light_serializer?)
        type.validator
      else
        type
      end
    end
  end
end
