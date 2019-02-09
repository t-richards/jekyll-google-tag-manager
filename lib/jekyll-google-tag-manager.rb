# frozen_string_literal: true

require 'jekyll-google-tag-manager/errors'
require 'jekyll-google-tag-manager/version'
require 'liquid'

# Add our tag to the Jekyll top-level module
module Jekyll
  # Google Tag Manager tag, renders Liquid templates
  class GoogleTagManager < Liquid::Tag
    attr_accessor :context

    PLACEHOLDER_ID = 'GTM-NNNNNNN'
    VALID_SECTIONS = %w[body head].freeze

    def initialize(_tag_name, text, _tokens)
      super
      @text = text.strip
      message = <<~MSG
        Invalid section specified: #{@text}.
        Please specify one of the following sections: #{VALID_SECTIONS.join(',')}
      MSG
      raise InvalidSectionError, message unless VALID_SECTIONS.include?(@text)
    end

    def render(context)
      @context = context
      template.render!(payload, info)
    end

    def template
      @template ||= Liquid::Template.parse template_contents
    end

    def options
      {
        'version' => Jekyll::GoogleTagManager::VERSION
      }
    end

    def container_id(config)
      config.dig('google', 'tag_manager', 'container_id') || PLACEHOLDER_ID
    rescue TypeError
      Jekyll.logger.warn('Your GTM container id is malformed or missing.')
      Jekyll.logger.warn("Using fallback: #{PLACEHOLDER_ID}")
      PLACEHOLDER_ID
    end

    def payload
      {
        'container_id' => container_id(context.registers[:site].config),
        'gtm_tag' => options
      }
    end

    def info
      {
        registers: context.registers,
        filters: [Jekyll::Filters]
      }
    end

    def template_contents
      @template_contents ||= begin
        File.read(template_path)
      end
    end

    def template_path
      @template_path ||= begin
        File.expand_path("./template-#{@text}.html", File.dirname(__FILE__))
      end
    end
  end
end

Liquid::Template.register_tag('gtm', Jekyll::GoogleTagManager)
