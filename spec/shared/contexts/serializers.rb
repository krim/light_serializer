# frozen_string_literal: true

RSpec.shared_context 'with base and nested serializers' do
  class NestedSerializer
    include ::LightSerializer::Serialization

    attributes(
      id: LightSerializer::Types::Integer,
      name: LightSerializer::Types::String
    )
  end

  class BaseSerializer
    include ::LightSerializer::Serialization

    attributes(
      id: LightSerializer::Types::Integer,
      name: LightSerializer::Types::String,
      nicknames: LightSerializer::Types::Array.of(LightSerializer::Types::String),
      active: LightSerializer::Types::Bool,
      options: LightSerializer::Types::Hash,
      rating: LightSerializer::Types::Float,
      created_at: LightSerializer::Types::Time,
      nested_resource: NestedSerializer
    )
  end
end
