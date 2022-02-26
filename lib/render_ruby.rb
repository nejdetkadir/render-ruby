# frozen_string_literal: true

require 'faraday'
require_relative 'render_ruby/version'

module RenderRuby
  autoload :Client, 'render_ruby/client'
  autoload :Error, 'render_ruby/error'
  autoload :Collection, 'render_ruby/collection'
  autoload :Resource, 'render_ruby/resource'
  autoload :Object, 'render_ruby/object'

  # resources
  autoload :OwnerResource, 'render_ruby/resources/owners'
  autoload :ServiceResource, 'render_ruby/resources/services'

  # objects
  autoload :Owner, 'render_ruby/objects/owner'
  autoload :Service, 'render_ruby/objects/service'
  autoload :EnvironmentVariable, 'render_ruby/objects/environment_variable'
  autoload :Header, 'render_ruby/objects/header'
  autoload :Rule, 'render_ruby/objects/rule'
end
