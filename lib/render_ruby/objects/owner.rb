# frozen_string_literal: true

module RenderRuby
  class Owner < Object
    def user?
      type.eql?('user')
    end

    def team?
      type.eql?('team')
    end
  end
end
