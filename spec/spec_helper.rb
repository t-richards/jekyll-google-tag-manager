# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end

if ENV['CI'] == 'true'
  require 'codecov'
  formatters = [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Codecov
  ]
  SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(formatters)
end

require 'rspec'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.order = :random

  config.before(:suite) do
    Liquid::Template.error_mode = :strict
  end

  config.before do
    Jekyll.logger.messages.clear
  end
end

require 'jekyll'
require 'jekyll-google-tag-manager'

Jekyll.logger = Logger.new(StringIO.new)

def make_site
  config = Jekyll.configuration
  Jekyll::Site.new(config)
end

def make_context
  Liquid::Context.new({}, {}, site: make_site)
end

def make_bad_context
  site = make_site
  site.config['google'] = Object.new
  Liquid::Context.new({}, {}, site: site)
end
