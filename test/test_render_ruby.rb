# frozen_string_literal: true

require 'test_helper'

class TestRenderRuby < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RenderRuby::VERSION
  end
end
