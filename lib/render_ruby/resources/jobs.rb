# frozen_string_literal: true

module RenderRuby
  class JobResource < Resource
    def list(service_id:, **params)
      response = get_request("services/#{service_id}/jobs", params: params)

      Collection.from_response(response, type: Job)
    end

    def retrieve(service_id:, job_id:)
      Job.new get_request("services/#{service_id}/jobs/#{job_id}").body
    end

    def create(service_id:, start_command:, **attributes)
      attributes = attributes.merge(startCommand: start_command)

      Job.new post_request("services/#{service_id}/jobs", body: attributes).body
    end
  end
end
