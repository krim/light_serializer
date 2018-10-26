# frozen_string_literal: true

RSpec.shared_context 'with base and nested serializers' do
  class BaseSerializer < ::LightSerializer::Serializer
    attributes(
      id: LightSerializer::Types::Strict::Integer,
      custom_attribute: LightSerializer::Types::Strict::String
    )

    def self.custom_attribute
      'string'
    end
  end

  class NestedSerializer < ::LightSerializer::Serializer
    attributes(
      another_custom_attribute: LightSerializer::Types::Strict::String,
      id: LightSerializer::Types::Strict::Integer,
      name: LightSerializer::Types::Strict::String
    )

    def self.another_custom_attribute
      'just string'
    end
  end

  class ChildSerializer < BaseSerializer
    attributes(
      name: LightSerializer::Types::Strict::String,
      nicknames: LightSerializer::Types::Array.of(LightSerializer::Types::Strict::String),
      active: LightSerializer::Types::Strict::Bool,
      options: LightSerializer::Types::Strict::Hash,
      rating: LightSerializer::Types::Strict::Float,
      created_at: LightSerializer::Types::Strict::Time,
      nested_resource: NestedSerializer,
      nested_resources: LightSerializer::Types::Array.of(NestedSerializer),
      custom_attribute: LightSerializer::Types::Strict::String
    )

    def self.custom_attribute
      'overwrote string'
    end
  end
end
