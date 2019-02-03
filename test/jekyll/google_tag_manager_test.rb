# frozen_string_literal: true

require "test_helper"

class Jekyll::GoogleTagManagerTest < Minitest::Test
  include Liquid

  def setup
    @gtm_tag = Jekyll::GoogleTagManager.parse(
      "gtm",
      "body",
      Tokenizer.new(""),
      ParseContext.new
    )
  end

  def test_that_it_has_a_version_number
    refute_nil ::Jekyll::GoogleTagManager::VERSION
  end

  def test_body_template_path
    tag = Jekyll::GoogleTagManager.parse(
      "gtm",
      "body",
      Tokenizer.new(""),
      ParseContext.new
    )
    assert(tag.template_path.end_with?(
      "jekyll-google-tag-manager/lib/template-body.html"
    ))
  end

  def test_head_template_path
    tag = Jekyll::GoogleTagManager.parse(
      "gtm",
      "head",
      Tokenizer.new(""),
      ParseContext.new
    )
    assert(tag.template_path.end_with?(
      "jekyll-google-tag-manager/lib/template-head.html"
    ))
  end

  def test_configuration_fetching
    config = { "google" => { "tag_manager" => { "container_id" => "correct" } } }
    assert_equal("correct", @gtm_tag.container_id(config))

    config = { "google" => { "tag_manager" => { "false_container_thing" => "derp" } } }
    assert_equal(
      Jekyll::GoogleTagManager::PLACEHOLDER_CONTAINER_ID,
      @gtm_tag.container_id(config)
    )

    config = {}
    assert_equal(
      Jekyll::GoogleTagManager::PLACEHOLDER_CONTAINER_ID,
      @gtm_tag.container_id(config)
    )
  end
end
