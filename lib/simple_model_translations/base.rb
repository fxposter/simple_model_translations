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

      delegate *(attributes + [:to => 'translation_helper.current_translation'.to_sym, :allow_nil => true])
      delegate *(attributes.map { |attr| "#{attr}=" } + [:to => 'translation_helper.find_or_build_current_translation'.to_sym])
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