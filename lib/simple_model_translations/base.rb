module SimpleModelTranslations
  
  module Base
    # Configure translation model dependency.
    # Eg:
    # class PostTranslation < ActiveRecord::Base
    #   translation_for :post
    # end
    def translation_for(model)
      belongs_to model
      validates_presence_of :locale
      validates_uniqueness_of :locale, :scope => "#{model}_id"
    end

    # Configure translated attributes.
    # Eg:
    # class Post < ActiveRecord::Base
    #   translates :title, :description
    # end
    def translates(*attributes)
      configure_translations(attributes.extract_options!)

      attributes.each do |attribute|
        # attribute setter
        define_method "#{attribute}=" do |value|
          translation = find_or_build_translation_by_locale(I18n.locale)
          translation.send("#{attribute}=", value)
        end

        # attribute getter
        define_method attribute do
          translation = find_translation_by_locale(current_locale_for_translation) || 
                        find_translation_by_locale(default_locale_for_translation)

          translation ? translation.send(attribute) : nil
        end
      end
    end

    private
      # configure model
      def configure_translations(options)
        raise 'You can call #translates method only once per model!' if included_modules.include?(SimpleModelTranslations::InstanceMethods)
        
        include SimpleModelTranslations::InstanceMethods
        include SimpleModelTranslations::Attributes
        
        class_name = options[:class_name] || "#{self.name}Translation"
        # unless Kernel.const_get(class_name)
        #   klass = Kernel.const_set(class_name.to_sym, Class.new(ActiveRecord::Base))
        #   klass.translation_for(self.name.underscore.to_sym)
        # end
        has_many :translations, :class_name => class_name, :dependent => :destroy, :order => "created_at DESC", :autosave => true
        
        if options[:accepts_nested_attributes]
          accepts_nested_attributes_for :translations, :allow_destroy => true
        end
      end
  end
end