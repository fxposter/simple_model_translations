module SimpleModelTranslations
  module ClassMethods
    def with_translations
      includes(:translations).where("#{translated_column_name(:id)} IS NOT NULL")
    end
    
    def translation_class
      Module.const_get(translation_class_name)
    end
    
    def translation_class_name
      class_name = translation_options[:class_name] || "#{self.name}Translation"
    end
    
    def translated_column_name(name)
      "#{translation_class.table_name}.#{name}".to_sym
    end
    
    def with_translated_attribute(name, value, locales = nil)
      with_translations.where(
          translated_column_name(name)    => value,
          translated_column_name(:locale) => Array(locales).map(&:to_s)
        )
    end
  end
end
