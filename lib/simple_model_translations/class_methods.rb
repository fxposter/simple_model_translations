module SimpleModelTranslations
  module ClassMethods
    def with_translations(*args)
      if args.empty?
        includes(:translations).where("#{translated_column_name(:id)} IS NOT NULL")
      else
        includes(:translations).where("#{translated_column_name(:locale)} IN (?)", args)
      end
    end
    alias with_translation with_translations
    
    def translation_class
      begin
        klass = const_get(translation_class_name.to_sym)
      rescue NameError => e
        klass = const_set(translation_class_name.to_sym, Class.new(ActiveRecord::Base))
        klass.translation_for(self.name.underscore.to_sym)
        klass.set_table_name(translation_class_name.underscore.pluralize)
      end
      klass
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
