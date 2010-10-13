$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'bundler'
Bundler.require(:default, :test)

require 'rspec'
require 'shoulda'
require 'factory_girl'
require 'active_record'
require 'simple_model_translations'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
DatabaseCleaner.strategy = :transaction

require 'spec/data/schema'
require 'spec/data/models'

RSpec.configure do |config|
  config.before do
    I18n.locale = :ru
    I18n.default_locale = :ru
    DatabaseCleaner.start
  end
  config.after do
    DatabaseCleaner.clean
  end
  
  config.mock_with :rspec
end

RSpec::Matchers.define :have_translation do |locale|
  match do |record|
    !record.find_translation_by_locale(locale).nil?
  end
end

RSpec::Matchers.define :have_translated_attribute do |locale, attribute, value|
  match do |record|
    record.find_translation_by_locale(locale).send(attribute) == value
  end
end
