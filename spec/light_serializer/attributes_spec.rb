# frozen_string_literal: true

require 'ostruct'
require 'light_serializer/attributes'

RSpec.describe LightSerializer::Attributes do
  subject(:prepared_attributes) { described_class.prepare(object) }

  let(:object_attributes) do
    {
      id: 1,
      name: 'Foo'
    }
  end
  let(:nested_object_attributes) do
    {
      id: 2,
      name: 'Bar'
    }
  end
  let(:object) do
    result = OpenStruct.new(object_attributes)
    result.nested_resource = OpenStruct.new(nested_object_attributes)
    result.nested_resources = [OpenStruct.new(nested_object_attributes)]
    result
  end

  let(:expected_hash) do
    object_attributes.merge(
      nested_resource: nested_object_attributes,
      nested_resources: [nested_object_attributes]
    )
  end

  describe '#to_hash' do
    it 'returns correct hash' do
      expect(prepared_attributes).to eq(expected_hash)
    end
  end
end
