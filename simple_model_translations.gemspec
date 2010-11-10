# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'simple_model_translations/version'
 
Gem::Specification.new do |s|
  s.name             = 'simple_model_translations'
  s.version          = SimpleModelTranslations::VERSION
  s.author           = 'Pavel Forkert'
  s.email            = 'fxposter@gmail.com'
  s.homepage         = 'http://github.com/fxposter/simple_model_translations'
  s.summary          = 'Simple ActiveRecord translations for Rails 3'
  s.description      = 'Simple ActiveRecord translations for Rails 3'
  s.require_path     = 'lib'
  s.files            = Dir.glob('{spec,lib}/**/*') + %w(Gemfile Gemfile.lock LICENSE Rakefile README.rdoc simple_model_translations.gemspec .rspec)
  s.test_files       = Dir.glob('spec/**/*')
  s.extra_rdoc_files = %w(LICENSE README.rdoc)

  s.required_rubygems_version = '>= 1.3.6'
  s.add_runtime_dependency('activerecord', '~> 3.0.0')
  s.add_development_dependency('database_cleaner', '~> 0.5.2')
  s.add_development_dependency('sqlite3-ruby', '~> 1.3.1')
  s.add_development_dependency('shoulda', '~> 2.11.3')
  s.add_development_dependency('rspec', '~> 2.0.0')
end
