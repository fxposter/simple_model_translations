module SimpleModelTranslations
  module Attributes
    def attributes=(attributes)
      I18n.with_locale(attributes.delete(:locale) || translation_helper.current_locale_for_translation) do
        super(attributes)
      end
    end

    def update_attributes!(attributes)
      I18n.with_locale(attributes.delete(:locale) || translation_helper.current_locale_for_translation) do
        super(attributes)
      end
    end

    def update_attributes(attributes)
      I18n.with_locale(attributes.delete(:locale) || translation_helper.current_locale_for_translation) do
        super(attributes)
      end
    end
  end
end
