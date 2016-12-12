require "jekyll-google-tag-manager/version"
require "liquid"

module Jekyll
  class GoogleTagManager < Liquid::Tag
    def initialize(_tag_name, text, _tokens)
      super
      @text = text
    end

    def render(context)
      @context = context
      template.render!(payload, info)
    end

    def template
      @template ||= Liquid::Template.parse template_contents
    end

    def template_path
      @template_path ||= begin
        File.expand_path("./template-#{@text}.html", File.dirname(__FILE__))
      end
    end
  end
end

Liquid::Template.register_tag("gtm", Jekyll::GoogleTagManager)
