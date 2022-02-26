# frozen_string_literal: true

module RenderRuby
  class Rule < Object
    TYPES = %w[redirect rewrite].freeze

    TYPES.each do |type|
      define_method "#{type}?" do
        type == self.type
      end
    end
  end
end
