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
  end
end
