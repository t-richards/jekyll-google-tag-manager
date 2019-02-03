# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require 'simplecov'
SimpleCov.start

require "jekyll"
require "jekyll-google-tag-manager"

require "minitest/autorun"
require "minitest/rg"

Jekyll.logger = Logger.new(StringIO.new)
