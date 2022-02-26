# frozen_string_literal: true

module RenderRuby
  class CustomDomainResource < Resource
    def list(service_id:, **params)
      response = get_request("services/#{service_id}/custom-domains", params: params)

      Collection.from_response(response, type: CustomDomain)
    end

    def retrieve(service_id:, custom_domain_id:)
      CustomDomain.new get_request("services/#{service_id}/custom-domains/#{custom_domain_id}").body
    end

    def create(service_id:, domain:)
      response = post_request("services/#{service_id}/custom-domains", body: { name: domain })

      Collection.from_response(response, type: CustomDomain)
    end

    def delete(service_id:, custom_domain_id:)
      delete_request("services/#{service_id}/custom-domains/#{custom_domain_id}")
    end
  end
end
