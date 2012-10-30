#!/usr/bin/env rake
require 'rake'
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rdoc/task'

desc 'Generate documentation for the timeline_fu plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'JqueryUI.CDN'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
