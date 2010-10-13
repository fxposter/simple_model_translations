module SimpleModelTranslations
  module Validations
    class TranslationsValidator < ActiveModel::Validator
      def validate(record)
        locales = options[:locales]
        locales = [locales] unless locales.respond_to?(:each)
        locales.each do |locale|
          unless record.find_translation_by_locale(locale)
            record.errors.add(:translations, "miss #{locale} translation")
          end
        end
      end
    end

    def validate_translations(*locales)
      validates_with TranslationsValidator, :locales => locales
    end
    
    def validate_translation(locale)
      validate_translations locale
    end
  end
end