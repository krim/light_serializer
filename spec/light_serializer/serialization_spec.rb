# frozen_string_literal: true

require 'ostruct'
require 'light_serializer/serialization'

RSpec.describe LightSerializer::Serialization do
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
    result.nested_resource = OpenStruct.new(object_attributes)
    result
  end

  let(:expected_hash) { object_attributes.merge(nested_resource: nested_object_attributes) }

  it 'returns correct hash' do
    expect(serialized_object.to_hash).to eq(expected_hash)
  end
end