# frozen_string_literal: true

module RenderRuby
  class DeployResource < Resource
    def list(service_id:, **params)
      response = get_request("services/#{service_id}/deploys", params: params)

      Collection.from_response(response, type: Deploy)
    end
  end
end
