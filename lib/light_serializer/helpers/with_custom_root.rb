# frozen_string_literal: true

module LightSerializer
  module Helpers
    module WithCustomRoot
      # :reek:UtilityFunction
      def with_custom_root(root)
        root ? { root.to_s => yield } : yield
      end
    end
  end
end
