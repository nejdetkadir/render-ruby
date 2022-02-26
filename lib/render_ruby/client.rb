# frozen_string_literal: true

module RenderRuby
  class Client
    BASE_URL = 'https://api.render.com/v1'

    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter, stubs: nil)
      @api_key = api_key
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def owners
      OwnerResource.new(self)
    end

    def services
      ServiceResource.new(self)
    end

    def deploys
      DeployResource.new(self)
    end

    def custom_domains
      CustomDomainResource.new(self)
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |conn|
        conn.request :authorization, :Bearer, api_key
        conn.request :json
        conn.response :json, content_type: 'application/json'

        conn.adapter adapter, @stubs
      end
    end
  end
end
