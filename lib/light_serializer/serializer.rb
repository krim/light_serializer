# frozen_string_literal: true

require 'oj'
require_relative 'hashed_object'

module LightSerializer
  class Serializer
    attr_reader :object

    class << self
      def attributes(*new_attributes)
        return @attributes if new_attributes.empty?

        @attributes = @attributes ? @attributes + new_attributes : new_attributes
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
      HashedObject.get(object, self)
    end
  end
end
