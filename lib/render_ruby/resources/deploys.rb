# frozen_string_literal: true

module RenderRuby
  class DeployResource < Resource
    def list(service_id:, **params)
      response = get_request("services/#{service_id}/deploys", params: params)

      Collection.from_response(response, type: Deploy)
    end

    def trigger(service_id:, clear_cache:)
      Deploy.new post_request("services/#{service_id}/deploys", body: { clearCache: clear_cache }).body
    end

    def retrieve(service_id:, deploy_id:)
      Deploy.new get_request("services/#{service_id}/deploys/#{deploy_id}").body
    end
  end
end
