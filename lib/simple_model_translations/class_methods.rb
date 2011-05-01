module SimpleModelTranslations
  module ClassMethods
    def with_translations(*args)
      current_scope = joins(:translations)
      current_scope = current_scope.where("#{translated_column_name(:locale)} IN (?)", args) unless args.empty?
      current_scope
    end
    alias with_translation with_translations
    
    def translation_class
      @translation_class ||=
        begin
          Object.const_get(translation_class_name)
        rescue NameError => e
          klass = Object.const_set(translation_class_name, Class.new(ActiveRecord::Base))
          klass.translation_for(name.underscore.to_sym)
          klass.set_table_name(translation_class_name.to_s.underscore.pluralize)
          klass
        end
    end
    
    def translation_class_name
      @translation_class_name ||= (translation_options[:class_name] || "#{self.name}Translation").to_sym
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
