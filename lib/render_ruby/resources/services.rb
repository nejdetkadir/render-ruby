# frozen_string_literal: true

module RenderRuby
  class ServiceResource < Resource
    def list(**params)
      response = get_request('services', params: params)

      Collection.from_response(response, type: Service)
    end

    def retrieve(service_id:)
      Service.new get_request("services/#{service_id}").body
    end

    def create(**attributes)
      Service.new post_request('services', body: attributes).body
    end

    def update(service_id:, **attributes)
      Service.new patch_request("services/#{service_id}", body: attributes).body
    end

    def delete(service_id:)
      delete_request("services/#{service_id}")
    end

    def suspend(service_id:)
      post_request("services/#{service_id}/suspend", body: {})
    end

    def resume(service_id:)
      post_request("services/#{service_id}/resume", body: {})
    end

    def retrieve_env_vars(service_id:, **params)
      response = get_request("services/#{service_id}/env-vars", params: params)

      Collection.from_response(response, type: EnvironmentVariable)
    end

    def update_env_var(service_id:, env_vars:)
      response = put_request("services/#{service_id}/env-vars", body: env_vars)

      Collection.from_response(response, type: EnvironmentVariable)
    end

    def retrieve_headers(service_id:, **params)
      response = get_request("services/#{service_id}/headers", params: params)

      Collection.from_response(response, type: Header)
    end

    def retrieve_redirect_and_rewrite_rules(service_id:, **params)
      response = get_request("services/#{service_id}/routes", params: params)

      Collection.from_response(response, type: Rule)
    end

    def scale(service_id:, num_instances:)
      Scale.new post_request("services/#{service_id}/scale", body: { numInstances: num_instances }).body
    end
  end
end
