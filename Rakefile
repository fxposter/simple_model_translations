require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "simple_model_translations"
    gem.summary = %Q{Simple ActiveRecord translations for Rails 3}
    gem.description = %Q{Simple ActiveRecord translations for Rails 3}
    gem.email = "fxposter@gmail.com"
    gem.homepage = "http://github.com/fxposter/simple_model_translations"
    gem.authors = ["Pavel Forkert"]
    gem.add_dependency "activerecord", '>= 3.0.0'
    
    gem.add_development_dependency 'database_cleaner'
    gem.add_development_dependency 'ruby-debug'
    gem.add_development_dependency 'sqlite3-ruby'
    gem.add_development_dependency 'shoulda'
    gem.add_development_dependency 'factory_girl'
    gem.add_development_dependency 'rspec', '>= 2.0.0'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "simple_model_translations #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
