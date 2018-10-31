# frozen_string_literal: true

require 'light_serializer/hashed_object'

RSpec.describe LightSerializer::HashedObject do
  include_context 'with base and nested serializers'

  subject(:hashed_object) { described_class.get(object, serializer) }

  let(:object) { OpenStruct.new(id: 1, name: 'test', external_field: 'external') }
  let(:serializer) { TinySeriaizer.new(object) }
  let(:expected_hash) { { id: 1, name: 'test' } }

  it 'correctly transform object to hash with correct keys' do
    expect(hashed_object).to eq(expected_hash)
  end

  context 'when serializer has custom methods for one of attribute' do
    let(:object) { OpenStruct.new(id: 1, name: 'test', custom_attribute: 'wrong value') }
    let(:serializer) { BaseSerializer.new(object) }
    let(:expected_hash) { { id: 1, custom_attribute: 'string' } }

    it 'gets value for attributes from serializer first' do
      expect(hashed_object).to eq(expected_hash)
    end
  end
end
