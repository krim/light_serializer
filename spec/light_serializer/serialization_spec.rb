# frozen_string_literal: true

require 'ostruct'
require 'light_serializer/serialization'

RSpec.describe LightSerializer::Serialization do
  subject(:serialized_object) { serializer_class.new(object).to_json }

  let(:serializer_class) do
    Class.new(described_class) do
      attributes(
        id: LightSerializer::Types::Integer,
        name: LightSerializer::Types::String,
        nicknames: LightSerializer::Types::Array.of(LightSerializer::Types::String),
        active: LightSerializer::Types::Bool,
        options: LightSerializer::Types::Hash,
        rating: LightSerializer::Types::Float,
        created_at: LightSerializer::Types::Time
      )
    end
  end

  let(:object_attributes) do
    {
      id: 123,
      name: 'Foo',
      nicknames: %w(Bar Baz),
      active: true,
      options: {
        color: 'red',
        count: 12,
      },
      rating: 3.5,
      created_at: Time.new(1999, 12, 31, 23, 59, 59)
    }
  end

  let(:object) do
    OpenStruct.new(object_attributes)
  end

  it 'returns correct hash' do
    expect(serialized_object).to eq(object_attributes)
  end
end
