# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "jekyll"
require "jekyll-google-tag-manager"

require "minitest/autorun"

Jekyll.logger = Logger.new(StringIO.new)
