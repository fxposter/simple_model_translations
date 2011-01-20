$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'simple_model_translations/version'

require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'rake/rdoctask'

RSpec::Core::RakeTask.new(:spec) do |spec|
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "simple_model_translations #{SimpleModelTranslations::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Build gem' 
task :build do
  system 'gem build simple_model_translations.gemspec'
  system 'mkdir pkg' unless File.exists?('pkg')
  system "mv simple_model_translations-#{SimpleModelTranslations::VERSION}.gem pkg"
end

desc 'Build and push gem to rubygems.org' 
task :release => :build do
  system "gem push pkg/simple_model_translations-#{SimpleModelTranslations::VERSION}.gem"
end

task :default => :spec
