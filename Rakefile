# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc 'Run mutation testing'
task :mutant do
  sh %w[
    bin/mutant
    --include lib
    --require jekyll-google-tag-manager
    --use rspec
    --
    Jekyll::GoogleTagManager
  ].join(' ')
end

task default: :spec
