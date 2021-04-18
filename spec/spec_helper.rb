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
  Jekyll::Site.new(Jekyll.configuration)
end

def make_context(value = nil)
  site = make_site
  site.config['google'] = value
  Liquid::Context.new({}, {}, site: site)
end
