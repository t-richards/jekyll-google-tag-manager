# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-google-tag-manager/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-google-tag-manager"
  spec.version       = Jekyll::GoogleTagManager::VERSION
  spec.authors       = ["Tom Richards"]
  spec.email         = ["tom@tomrichards.net"]

  spec.summary       = "A Jekyll plugin to add Google Tag Manager snippets to your site."
  spec.homepage      = "https://github.com/t-richards/jekyll-google-tag-manager"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").grep(/^(LICENSE|README\.md|lib)/)
  spec.require_paths = ["lib"]

  # Require Ruby 2.3 for Hash#dig
  spec.required_ruby_version = '>= 2.3.1'

  spec.add_dependency "jekyll", "~> 3.3"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rubocop", "~> 0.49.0"
end
