# frozen_string_literal: true

require 'test_helper'

module Jekyll
  class GoogleTagManagerTest < Minitest::Test
    include Liquid

    def setup
      Liquid::Template.error_mode = :strict

      @gtm_tag = Jekyll::GoogleTagManager.parse(
        'gtm',
        'body',
        Tokenizer.new(''),
        ParseContext.new
      )
    end

    def test_that_it_has_a_version_number
      refute_nil ::Jekyll::GoogleTagManager::VERSION
    end

    def test_body_template_path
      tag = Jekyll::GoogleTagManager.parse(
        'gtm',
        'body',
        Tokenizer.new(''),
        ParseContext.new
      )
      assert(tag.template_path.end_with?('lib/template-body.html'))
    end

    def test_head_template_path
      tag = Jekyll::GoogleTagManager.parse(
        'gtm',
        'head',
        Tokenizer.new(''),
        ParseContext.new
      )
      assert(tag.template_path.end_with?('lib/template-head.html'))
    end

    def test_normal_configuration_fetching
      config = {
        'google' => {
          'tag_manager' => {
            'container_id' => 'correct'
          }
        }
      }
      assert_equal('correct', @gtm_tag.container_id(config))
    end

    def test_fallback_configuration_fetching
      config = {
        'google' => {
          'tag_manager' => {
            'false_container_thing' => 'derp'
          }
        }
      }
      expected_id = 'GTM-NNNNNNN'
      assert_equal(expected_id, @gtm_tag.container_id(config))
    end

    def test_empty_configuration_fetching
      config = {}
      expected_id = 'GTM-NNNNNNN'
      assert_equal(expected_id, @gtm_tag.container_id(config))
    end

    def test_it_renders_head_tag_properly
      context = make_context
      tag = Liquid::Template.parse('{% gtm head %}')

      output = tag.render!(context)

      assert_includes(output, 'script')
      assert_includes(output, 'gtm.js')
    end

    def test_it_renders_body_tag_properly
      context = make_context
      tag = Liquid::Template.parse('{% gtm body %}')

      output = tag.render!(context)

      assert_includes(output, 'iframe')
      assert_includes(output, 'ns.html')
    end

    def test_it_gracefully_handles_malformed_config
      context = make_bad_context
      tag = Liquid::Template.parse('{% gtm body %}')

      tag.render!(context)

      assert_includes(Jekyll.logger.messages, 'Using fallback: GTM-NNNNNNN ')
    end

    def test_it_gracefully_handles_invalid_text
      assert_raises(Jekyll::GoogleTagManager::InvalidSectionError) do
        Liquid::Template.parse('{% gtm foobar %}')
      end
    end

    def test_it_has_the_proper_superclass
      assert_equal(Liquid::Tag, Jekyll::GoogleTagManager.superclass)
    end
  end
end
