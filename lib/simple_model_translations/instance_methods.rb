require 'simple_model_translations/translation_helper'

module SimpleModelTranslations
  module InstanceMethods
    def translation_helper
      @translation_helper ||= SimpleModelTranslations::TranslationHelper.new(self)
    end
  end
end
