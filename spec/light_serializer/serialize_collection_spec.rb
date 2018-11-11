# frozen_string_literal: true

require 'light_serializer/serialize_collection'

RSpec.describe LightSerializer::SerializeCollection do
  include_context 'with base and nested serializers'

  subject(:serialized_collection) { described_class.new(collection, serializer: ChildWithUsingObject) }

  let(:collection) do
    [OpenStruct.new(id: 1, name: 'ololo', nested_resources: [OpenStruct.new(id: 1, name: 'nested_ololo')])]
  end
  let(:expected_hash) do
    [{ uuid: 1, login: 'ololo', nested_resources: [{ login: 'nested_ololo' }] }]
  end

  context '#to_json' do
    let(:hash_result) do
      Oj.load(serialized_collection.to_json, mode: :compat, symbol_keys: true)
    end

    it 'correctly serialized collection' do
      expect(hash_result).to eq(expected_hash)
    end
  end

  context '#to_hash' do
    let(:hash_result) { serialized_collection.to_hash }

    it 'correctly hashed collection' do
      expect(hash_result).to eq(expected_hash)
    end
  end

  context 'when one of serializers use SerializeCollection in custom method' do
    subject(:serialized_collection) { ChildWithSerializeCollection.new(collection.first) }

    let(:expected_hash) do
      { id: 1, login: 'ololo', nested_resources: [{ login: 'nested_ololo' }] }
    end
    let(:hash_result) { serialized_collection.to_hash }

    it 'correctly hashed it' do
      expect(hash_result).to eq(expected_hash)
    end
  end
end
