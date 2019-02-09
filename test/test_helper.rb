# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'simplecov'
SimpleCov.start

if ENV['CI'] == 'true'
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'jekyll'
require 'jekyll-google-tag-manager'

require 'minitest/autorun'
require 'minitest/rg'

Jekyll.logger = Logger.new(StringIO.new)

def make_site
  config = Jekyll.configuration
  Jekyll::Site.new(config)
end

def make_context
  Liquid::Context.new({}, {}, site: make_site)
end
