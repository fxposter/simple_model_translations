$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'rubygems'
require 'rake'
require 'simple_model_translations/version'
require 'rspec/core/rake_task'
require 'rake/rdoctask'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = %w(-fs --color)
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "simple_model_translations #{SimpleModelTranslations::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :build do
  system 'gem build .gemspec'
end
 
task :release => :build do
  system "gem push simple_model_translations-#{SimpleModelTranslations::VERSION}"
end

task :default => :spec
