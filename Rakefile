# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

namespace :spec do
  desc 'Run mutation testing'
  task :mutant do
    sh "bin/mutant --include lib --require 'jekyll-google-tag-manager' --use rspec --fail-fast -- 'Jekyll::GoogleTagManager'"
  end
end

task default: :test
