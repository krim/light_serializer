# frozen_string_literal: true

RSpec.shared_context 'with base and nested serializers' do
  class TinySeriaizer < ::LightSerializer::Serializer
    attributes(
      :id,
      :name
    )
  end

  class TinyWithNestedAttributeSerializer < ::LightSerializer::Serializer
    attributes(
      :id,
      :name,
      nested_attribute: TinySeriaizer
    )
  end

  class TinyWithContext < ::LightSerializer::Serializer
    attributes(
      :url_from_context
    )

    def url_from_context
      context.url
    end
  end

  class ChildWithContext < TinyWithContext
    attributes(
      nested_attribute: TinyWithContext
    )
  end

  class BaseSerializer < ::LightSerializer::Serializer
    attributes(
      :id,
      :custom_attribute
    )

    def custom_attribute
      'string'
    end
  end

  class NestedSerializer < ::LightSerializer::Serializer
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
