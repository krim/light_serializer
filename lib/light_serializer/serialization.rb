# frozen_string_literal: true

require 'oj'
require_relative 'hashed_object'

module LightSerializer
  module Serialization
    attr_reader :object

    def self.included(base)
      base.extend(ClassAttributes)
    end

    module ClassAttributes
      def attributes(*attributes)
        return @attributes if attributes.empty?

        @attributes = @attributes ? @attributes + attributes : attributes
      end

      def inherited(subclass)
        subclass.attributes(*attributes)
        super(subclass)
      end
    end

    def initialize(object)
      @object = object
    end

    def to_json
      Oj.dump(hashed_object, mode: :compat)
    end

    def to_hash
      hashed_object
    end

    private

    def hashed_object
      object.is_a?(Enumerable) ? object.map { |entity| HashedObject.get(entity, self) } : HashedObject.get(object, self)
    end
  end
end
