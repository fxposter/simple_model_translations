require 'active_record'
require 'simple_model_translations/base'
require 'simple_model_translations/class_methods'
require 'simple_model_translations/instance_methods'
require 'simple_model_translations/attributes'
require 'simple_model_translations/validations'

ActiveRecord::Base.extend SimpleModelTranslations::Base
ActiveRecord::Base.extend SimpleModelTranslations::Validations
