# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.options = '--rg'
  t.verbose = true
end

namespace :test do
  desc 'Run mutation testing'
  task :mutant do
    sh "bin/mutant --include lib --require 'jekyll-google-tag-manager' --use rspec -- 'Jekyll::GoogleTagManager'"
  end
end

task default: :test
