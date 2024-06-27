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

  spec.required_ruby_version = '>= 2.7.0'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.add_dependency 'jekyll', '>= 3.3', '< 5.0'
end
