# frozen_string_literal: true

require 'ostruct'
require 'light_serializer/serializer'

RSpec.describe LightSerializer::Serializer do
  include_context 'with base and nested serializers'

  subject(:serialized_object) { ChildSerializer.new(object) }

  let(:object_attributes) do
    {
      id: 123,
      name: 'Foo',
      nicknames: %w[Bar Baz],
      active: true,
      options: {
        color: 'red',
        count: 12
      },
      rating: 3.5,
      created_at: Time.new(1999, 12, 31, 23, 59, 59)
    }
  end
  let(:nested_object_attributes) do
    {
      id: 123,
      name: 'Foo'
    }
  end
  let(:object) do
    result = OpenStruct.new(object_attributes)
    result.nested_resource = OpenStruct.new(nested_object_attributes)
    result.nested_resources = [OpenStruct.new(nested_object_attributes)]
    result
  end
  let(:result) do
    object_attributes.merge(
      nested_resource: nested_object_attributes.merge(another_custom_attribute: 'just string'),
      nested_resources: [nested_object_attributes.merge(another_custom_attribute: 'just string')]
    )
  end

  let(:expected_hash) { result.merge(custom_attribute: 'overwrote string') }

  describe '#to_hash' do
    it 'returns correct hash' do
      expect(serialized_object.to_hash).to eq(expected_hash)
    end
  end

  describe '#to_json' do
    subject(:hash_result) do
      Oj.load(serialized_object.to_json, mode: :compat, symbol_keys: true)
    end

    before { expected_hash[:created_at] = expected_hash[:created_at].to_s }

    it 'returns correct json' do
      expect(hash_result).to eq(expected_hash)
    end

    context 'when serializer has a custom name for root' do
      subject(:serialized_object) { ChildSerializer.new(object, root: :custom) }

      let(:expected_hash_with_root) { { custom: expected_hash } }

      it 'returns correct json' do
        expect(hash_result).to eq(expected_hash_with_root)
      end
    end
  end
end