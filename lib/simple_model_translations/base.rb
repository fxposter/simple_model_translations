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
    #   translates :title, :description, :attributes => true
    # end
    def translates(*attributes, &block)
      configure_translations(attributes.extract_options!)
      translation_class.class_eval(&block) if block_given?

      attributes.each do |attribute|
        # attribute setter
        define_method "#{attribute}=" do |value|
          translation = find_or_build_translation_by_locale(I18n.locale)
          translation.send("#{attribute}=", value)
        end

        # attribute getter
        define_method attribute do
          current_translation ? current_translation.send(attribute) : nil
        end
      end
    end

    private
      # configure model
      def configure_translations(options)
        raise 'You can call #translates method only once per model!' if included_modules.include?(SimpleModelTranslations::InstanceMethods)
        
        (class << self; self; end).send :define_method, :translation_options do
          options
        end
        
        include SimpleModelTranslations::InstanceMethods
        include SimpleModelTranslations::Attributes
        extend SimpleModelTranslations::ClassMethods
        
        has_many :translations, :class_name => translation_class.name, :dependent => :destroy, :autosave => true, :validate => true
        
        if options[:attributes]
          nested_attributes = options[:attributes].is_a?(Hash) ? options[:attributes] : {}
          accepts_nested_attributes_for :translations, nested_attributes.reverse_merge(:allow_destroy => true)
        end
      end
  end
end