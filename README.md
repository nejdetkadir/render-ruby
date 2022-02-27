[![Gem Version](https://badge.fury.io/rb/render_ruby.svg)](https://badge.fury.io/rb/render_ruby)
![test](https://github.com/nejdetkadir/render-ruby/actions/workflows/test.yml/badge.svg?branch=main)
![rubocop](https://github.com/nejdetkadir/render-ruby/actions/workflows/rubocop.yml/badge.svg?branch=main)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
![Ruby Version](https://img.shields.io/badge/ruby_version->=_2.6.0-blue.svg)

# RenderRuby
Ruby bindings for [Render API](https://api-docs.render.com)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'render_ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install render_ruby

## Usage
To access the API, you'll need to create a RenderRuby::Client and pass in your API key. You can find your API key at https://render.com/docs/api

```ruby
client = RenderRuby::Client.new(api_key: ENV['RENDER_API_KEY'])
```
The client then gives you access to each of the resources.

## Resources
The gem maps as closely as we can to the Render API so you can easily convert API examples to gem code.

Responses are created as objects like RenderRuby::Owner. Having types like RenderRuby::Owner is handy for understanding what type of object you're working with. They're built using OpenStruct so you can easily access data in a Ruby-ish way.

#### Pagination

`list` endpoints return pages of results. The result object will have a data key to access the results, as well as metadata like next_cursor and prev_cursor for retrieving the next and previous pages. You may also specify the

```ruby
results = client.owners.list(limit: 100) # limit is optional, defaults to 20.
#=> RenderRuby::Collection

results.total
#=> 55

results.data
#=> [#<RenderRuby::Owner>, #<RenderRuby::Owner>]

results.next_cursor
#=> "XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ"

# Retrieve the next page
client.owners.list(limit: 100, cursor: results.next_cursor)
#=> RenderRuby::Collection
```

### Owners
```ruby
response = client.owners.list
#=> RenderRuby::Collection

response.data.first.user?
#=> true

response.data.first.team?
#=> false

client.owners.retrieve(owner_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> RenderRuby::Owner
```

### Services
```ruby
client.services.list
#=> RenderRuby::Collection

service = client.services.retrieve(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> RenderRuby::Service

service.auto_deploy_enabled?
#=> true

service.suspended?
#=> false

RenderRuby::Service::TYPES
#=> ['static_site', 'web_service', 'private_service', 'background_worker', 'cron_job']

client.services.create(
  type: RenderRuby::Service::TYPES.sample,
  name: 'foo bar',
  ownerId: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ',
  repo: 'https://github.com/render-examples/flask-hello-world',
  autoDeploy: 'yes', # or 'no',
  branch: 'master'
)
#=> RenderRuby::Service

client.services.update(
  service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ',
  name: 'foo bar',
  autoDeploy: 'yes', # or 'no',
  branch: 'master'
)
#=> RenderRuby::Service

client.services.delete(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> Faraday::Response

client.services.suspend(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> Faraday::Response

client.services.resume(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> Faraday::Response

client.services.retrieve_env_vars(service_id:'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> RenderRuby::Collection

client.services.update_env_var(
  service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ',
  env_vars: [
    {
       name: 'FOO',
       value: 'bar'
    }
  ]
)
#=> RenderRuby::EnvironmentVariable

client.services.retrieve_headers(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> RenderRuby::Collection

results = client.services.retrieve_redirect_and_rewrite_rules(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> RenderRuby::Collection

results.data.first.redirect?
#=> true

results.data.first.rewrite?
#=> false

client.services.scale(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ', num_instances: 1)
#=> RenderRuby::Scale
```

### Jobs
```ruby
client.jobs.list(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> RenderRuby::Collection

client.jobs.retrieve(service_id: 'XMTjXEjiQJm', job_id: 'XMTjXEjiQJ')
#=> RenderRuby::Job

client.jobs.create(
  service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ',
  start_command: 'yarn dev',
  planId: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ' # optional
)
#=> RenderRuby::Job
```

### Deploys
```ruby
client.deploys.list(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> RenderRuby::Collection

client.deploys.retrieve(service_id: 'XMTjXEjiQJm', deploy_id: 'XMTjXEjiQJ')
#=> RenderRuby::Deploy

client.deploys.trigger(
  service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ',
  clear_cache: 'clear' # or 'do_not_clear'
)
#=> RenderRuby::Deploy
```

### Custom Domains
```ruby
client.custom_domains.list(service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ')
#=> RenderRuby::Collection

client.custom_domains.retrieve(service_id: 'XMTjXEjiQJm', custom_domain_id: 'XMTjXEjiQJ')
#=> RenderRuby::CustomDomain

client.custom_domains.create(
  service_id: 'XMTjXEjiQJmNjEwZ2QwZWQ5N2x2MGZ',
  domain: 'www.nejdetkadirbektas.com'
)
#=> RenderRuby::CustomDomain

client.custom_domains.delete(service_id: 'XMTjXEjiQJm', custom_domain_id: 'XMTjXEjiQJ')
#=> Faraday::Response
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nejdetkadir/render-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nejdetkadir/render-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).

## Code of Conduct

Everyone interacting in the RenderRuby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nejdetkadir/render-ruby/blob/main/CODE_OF_CONDUCT.md).
