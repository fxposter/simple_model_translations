require 'simple_model_translations'
require 'rails'

module SimpleModelTranslations
  class Railtie < Rails::Railtie    
    initializer "simple_model_translations.active_record" do
      ActiveSupport.on_load :active_record do
        extend SimpleModelTranslations::Base
        extend SimpleModelTranslations::Validations
      end
    end
  end
end