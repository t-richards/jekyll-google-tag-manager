# frozen_string_literal: true

require_relative 'lib/jekyll-google-tag-manager/version'

Gem::Specification.new do |spec|
  spec.name = 'jekyll-google-tag-manager'
  spec.version = Jekyll::GoogleTagManager::VERSION
  spec.authors = ['Tom Richards']
  spec.email = ['tom@tomrichards.net']

  spec.summary = 'A Jekyll plugin to add Google Tag Manager snippets to your site'
  spec.homepage = 'https://github.com/t-richards/jekyll-google-tag-manager'
  spec.license = 'MIT'

  all_files = `git ls-files -z`.split("\x0")
  spec.files = all_files.grep(%r{^(lib)/})
  spec.extra_rdoc_files = %w[README.md LICENSE]
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.4.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'codecov', '~> 0.1'
  spec.add_development_dependency 'irb', '~> 1.0'
  spec.add_development_dependency 'mutant-rspec', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'simplecov', '~> 0.16'

  spec.add_dependency 'jekyll', '>= 3.3', '< 5.0'
end
