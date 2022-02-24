# frozen_string_literal: true

module RenderRuby
  class Service < Object
    def auto_deploy_enabled?
      autoDeploy.equal?('yes')
    end

    def suspended?
      suspended.equal?('suspended')
    end
  end
end
