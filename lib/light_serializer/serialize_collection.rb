# frozen_string_literal: true

module LightSerializer
  class SerializeCollection
    include Helpers::WithCustomRoot

    attr_reader :collection, :serializer, :root, :context

    def initialize(collection, serializer:, root: nil, context: nil)
      @collection = collection
      @serializer = serializer
      @root = root
      @context = context
    end

    def to_json(*_args)
      Oj.dump(collection_with_root, mode: :compat)
    end

    def to_hash
      hashed_collection
    end

    private

    def collection_with_root
      with_custom_root(root) { hashed_collection }
    end

    def hashed_collection
      collection.map { |entity| serializer.new(entity, context: context).to_hash }
    end
  end
end
