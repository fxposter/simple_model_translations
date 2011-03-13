module SimpleModelTranslations
  module Validations
    class TranslationsValidator < ::ActiveModel::Validator
      def validate(record)
        Array.wrap(options[:locales]).each do |locale|
          unless record.translation_helper.find_translation_by_locale(locale)
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