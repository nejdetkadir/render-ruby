# frozen_string_literal: true

require 'faraday'
require_relative 'render_ruby/version'

module RenderRuby
  autoload :Client, 'render_ruby/client'
  autoload :Error, 'render_ruby/error'
  autoload :Resource, 'render_ruby/resource'
  autoload :Object, 'render_ruby/object'
end
