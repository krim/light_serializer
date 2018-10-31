# frozen_string_literal: true

require 'light_serializer/serialization'

RSpec.describe LightSerializer::Validator do
  include_context 'with base and nested serializers'

  subject(:validator) { described_class.get(attributes) }

  let(:attributes) { TinySeriaizer.attributes }

  it 'correctly builds struct for validation' do
    expect(validator.superclass).to eq(Dry::Struct)
    expect(validator.schema).to eq(attributes)
  end
end
