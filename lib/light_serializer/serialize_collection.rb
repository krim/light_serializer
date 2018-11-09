# frozen_string_literal: true

require 'light_serializer/helpers/with_custom_root'
require 'light_serializer/serializer'

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

    def to_json
      with_custom_root(root) { Oj.dump(hashed_collection, mode: :compat) }
    end

    def to_hash
      hashed_collection
    end

    private

    def hashed_collection
      collection.map { |entity| serializer.new(entity, context: context).to_hash }
    end
  end
end
