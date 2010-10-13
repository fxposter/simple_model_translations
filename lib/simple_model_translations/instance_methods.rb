module SimpleModelTranslations
  module InstanceMethods
    def find_translation_by_locale(locale)
      translations.detect { |t| t.locale.to_sym == locale }
    end
    
    def find_or_build_translation_by_locale(locale)
      find_translation_by_locale(locale) || build_translation_for_locale(locale)
    end
    
    def build_translation_for_locale(locale)
      translations.build(:locale => locale)
    end
    
    def current_locale_for_translation
      I18n.locale
    end
    
    def default_locale_for_translation
      I18n.default_locale
    end
  end
end
