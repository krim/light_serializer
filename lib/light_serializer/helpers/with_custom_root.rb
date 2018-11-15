# frozen_string_literal: true

module LightSerializer
  module Helpers
    module WithCustomRoot
      def with_custom_root(root)
        root ? { root.to_sym => yield } : yield
      end
    end
  end
end
