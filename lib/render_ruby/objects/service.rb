# frozen_string_literal: true

module RenderRuby
  class Service < Object
    TYPES = %w[static_site web_service private_service background_worker cron_job].freeze

    def auto_deploy_enabled?
      autoDeploy.equal?('yes')
    end

    def suspended?
      suspended.equal?('suspended')
    end
  end
end
