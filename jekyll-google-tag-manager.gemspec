# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-google-tag-manager/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-google-tag-manager"
  spec.version       = Jekyll::GoogleTagManager::VERSION
  spec.authors       = ["Tom Richards"]
  spec.email         = ["tom@tomrichards.net"]

  spec.summary       = "A Jekyll plugin to add Google Tag Manager snippets to your site."
  spec.homepage      = "https://github.com/t-richards/jekyll-google-tag-manager"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").grep(%r!^(LICENSE|README\.md|lib)!)
  spec.require_paths = ["lib"]

  # Require Ruby 2.3 for Hash#dig
  spec.required_ruby_version = ">= 2.3.1"

  spec.add_dependency "jekyll", "~> 3.3"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "irb", "~> 1.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rubocop", "~> 0.56.0"
end
