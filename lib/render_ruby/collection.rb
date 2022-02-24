# frozen_string_literal: true

module RenderRuby
  class Collection
    attr_reader :data, :total, :next_cursor, :prev_cursor

    def self.from_response(response, type:)
      body = response.body
      new(
        data: body.map { |attrs| type.new(attrs) },
        total: body.count,
        next_cursor: body.last['cursor'],
        prev_cursor: body.first['cursor']
      )
    end

    def initialize(data:, total:, next_cursor:, prev_cursor:)
      @data = data
      @total = total
      @next_cursor = next_cursor.empty? ? nil : next_cursor
      @prev_cursor = prev_cursor.empty? ? nil : prev_cursor
    end
  end
end