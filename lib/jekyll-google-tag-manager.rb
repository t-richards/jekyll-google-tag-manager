# frozen_string_literal: true

require "jekyll-google-tag-manager/version"
require "liquid"

module Jekyll
  class GoogleTagManager < Liquid::Tag
    attr_accessor :context

    PLACEHOLDER_CONTAINER_ID = "GTM-NNNNNNN".freeze

    def initialize(_tag_name, text, _tokens)
      super
      @text = text.strip
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
        "version" => Jekyll::GoogleTagManager::VERSION,
      }
    end

    def container_id(config)
      id = config.fetch("google", {}).fetch("tag_manager", {}).fetch("container_id", nil)
      return PLACEHOLDER_CONTAINER_ID if id.nil?

      id
    rescue TypeError
      Jekyll.logger.warn("Your GTM container id is malformed or missing.")
      Jekyll.logger.warn("Using fallback: #{PLACEHOLDER_CONTAINER_ID}")
      PLACEHOLDER_CONTAINER_ID
    end

    def payload
      {
        "container_id" => container_id(context.registers[:site].config),
        "gtm_tag"      => options,
      }
    end

    def info
      {
        :registers => context.registers,
        :filters   => [Jekyll::Filters],
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

Liquid::Template.register_tag("gtm", Jekyll::GoogleTagManager)
