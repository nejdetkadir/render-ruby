# frozen_string_literal: true

module RenderRuby
  class OwnerResource < Resource
    def list(**params)
      response = get_request('owners', params: params)

      Collection.from_response(response, type: Owner)
    end

    def retrieve(owner_id:)
      Owner.new get_request("owners/#{owner_id}").body
    end
  end
end
