# frozen_string_literal: true

require 'light_serializer/hashed_object'

RSpec.describe LightSerializer::HashedObject do
  include_context 'with base and nested serializers'

  subject(:hashed_object) { described_class.get(object, serializer) }

  let(:object) { OpenStruct.new(id: 1, name: 'test', external_field: 'external') }
  let(:serializer) { TinySeriaizer.new(object) }
  let(:expected_hash) { { id: 1, name: 'test' } }

  shared_examples 'transform object to correct hash' do
    specify { expect(hashed_object).to eq(expected_hash) }
  end

  it_behaves_like 'transform object to correct hash'

  context 'when serializer with empty attributes' do
    let(:object) { OpenStruct.new(id: 1) }
    let(:serializer) { EmptySeriaizer.new(object) }
    let(:expected_hash) { {} }

    it_behaves_like 'transform object to correct hash'
  end

  context 'when serializer has custom methods for one of attribute' do
    let(:object) { OpenStruct.new(id: 1, name: 'test', custom_attribute: 'wrong value') }
    let(:serializer) { BaseSerializer.new(object) }
    let(:expected_hash) { { id: 1, custom_attribute: 'string' } }

    it_behaves_like 'transform object to correct hash'
  end

  context 'when serializer has nested serialization for one of attribute' do
    let(:object) do
      OpenStruct.new(
        id: 1,
        name: 'test',
        nested_attribute: OpenStruct.new(id: 2, name: 'nested'),
        additional_nested_attribute: OpenStruct.new(id: 3, name: 'additional_nested')
      )
    end
    let(:serializer) { TinyWithNestedAttributeSerializer.new(object) }
    let(:expected_hash) do
      {
        id: 1,
        name: 'test',
        nested_attribute: { id: 2, name: 'nested' },
        additional_nested_attribute: { id: 3, name: 'additional_nested' }
      }
    end

    it_behaves_like 'transform object to correct hash'

    context 'when attribute is an array of objects' do
      let(:object) do
        OpenStruct.new(
          id: 1,
          extra_field: 'extra',
          name: 'test',
          nested_attribute: [OpenStruct.new(id: 2, extra_field: 'nested_extra', name: 'nested')],
          additional_nested_attribute: [OpenStruct.new(id: 3, extra_field: 'nested_extra', name: 'additional_nested')]
        )
      end
      let(:expected_hash) do
        {
          id: 1,
          name: 'test',
          nested_attribute: [{ id: 2, name: 'nested' }],
          additional_nested_attribute: [{ id: 3, name: 'additional_nested' }]
        }
      end

      it_behaves_like 'transform object to correct hash'
    end

    context 'when serializer has a custom name for root' do
      let(:serializer) { TinyWithNestedAttributeSerializer.new(object, root: :tiny_object) }
      let(:expected_hash) { { 'tiny_object' => super() } }

      it_behaves_like 'transform object to correct hash'
    end
  end
end
