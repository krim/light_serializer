# frozen_string_literal: true

RSpec.shared_context 'with base and nested serializers' do
  class TinySeriaizer
    include ::LightSerializer::Serialization

    attributes(
      :id,
      :name
    )
  end

  class TinyWithNestedAttributeSerializer
    include ::LightSerializer::Serialization

    attributes(
      :id,
      :name,
      nested_attribute: TinySeriaizer
    )
  end

  class BaseSerializer
    include ::LightSerializer::Serialization

    attributes(
      :id,
      :custom_attribute
    )

    def custom_attribute
      'string'
    end
  end

  class NestedSerializer
    include ::LightSerializer::Serialization

    attributes(
      :id,
      :name,
      :another_custom_attribute
    )

    def another_custom_attribute
      'just string'
    end
  end

  class ChildSerializer < BaseSerializer
    attributes(
      :name,
      :nicknames,
      :active,
      :options,
      :rating,
      :created_at,
      { nested_resource: NestedSerializer },
      { nested_resources: NestedSerializer },
      :custom_attribute
    )

    def custom_attribute
      'overwrote string'
    end
  end
end
