# frozen_string_literal: true

module LightSerializer
  class Serializer
    attr_reader :object, :root, :context, :meta

    def self.attributes(*new_attributes)
      return @attributes if new_attributes.empty?

      @attributes = @attributes ? @attributes.concat(new_attributes) : new_attributes
    end

    def self.inherited(subclass)
      subclass.attributes(*attributes)
      super(subclass)
    end

    def initialize(object, root: nil, context: nil, meta: nil)
      @object = object
      @root = root
      @context = context
      @meta = meta
    end

    def to_json
      Oj.dump(to_hash, mode: :compat)
    end

    def to_hash
      meta ? hashed_object.merge!(meta: meta) : hashed_object
    end

    private

    def hashed_object
      HashedObject.get(object, self)
    end
  end
end
