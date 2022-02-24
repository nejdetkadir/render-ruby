# frozen_string_literal: true

module RenderRuby
  class ServiceResource < Resource
    def list(**params)
      response = get_request('services', params: params)

      Collection.from_response(response, type: Service)
    end
  end
end
