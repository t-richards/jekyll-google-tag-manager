# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-google-tag-manager/version'

Gem::Specification.new do |spec|
  spec.name = 'jekyll-google-tag-manager'
  spec.version = Jekyll::GoogleTagManager::VERSION
  spec.authors = ['Tom Richards']
  spec.email = ['tom@tomrichards.net']

  spec.summary = <<~SUMMARY
    A Jekyll plugin to add Google Tag Manager snippets to your site.
  SUMMARY
  spec.homepage = 'https://github.com/t-richards/jekyll-google-tag-manager'
  spec.license = 'MIT'

  all_files = `git ls-files -z`.split("\x0")
  spec.files = all_files.grep(%r{^(lib)/})
  spec.extra_rdoc_files = %w[README.md LICENSE]
  spec.require_paths = ['lib']

  # Require Ruby 2.3 for Hash#dig and squiggly heredoc
  spec.required_ruby_version = '>= 2.3.1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'codecov', '~> 0.1'
  spec.add_development_dependency 'irb', '~> 1.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-rg', '~> 5.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'mutant-minitest', '~> 0.8.24'

  spec.add_dependency 'jekyll', '>= 3.3', '< 5.0'
end
