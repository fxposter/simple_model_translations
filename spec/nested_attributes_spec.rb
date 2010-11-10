require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SimpleModelTranslations do
  context 'when generating nested attributes' do
    before do
      SomeModel = Class.new(ActiveRecord::Base)
    end
    
    after do
      Object.send(:remove_const, :SomeModel)
    end
    
    it 'can use options[:attributes] as a Hash' do
      options = { :reject_if => lambda { |attrs| attrs[:name].blank? } }
      SomeModel.should_receive(:accepts_nested_attributes_for).with(:translations, options.merge(:allow_destroy => true))
      SomeModel.translates :name, :attributes => options
    end
    
    it 'can use options[:attributes] as a Boolean' do
      SomeModel.should_receive(:accepts_nested_attributes_for).with(:translations, { :allow_destroy => true })
      SomeModel.translates :name, :attributes => true
    end
    
    it "should enable translations' deletion by default" do
      SomeModel.should_receive(:accepts_nested_attributes_for).with(:translations, { :allow_destroy => true })
      SomeModel.translates :name, :attributes => true
    end
    
    it "should allow to disable translations' deletion" do
      SomeModel.should_receive(:accepts_nested_attributes_for).with(:translations, { :allow_destroy => false })
      SomeModel.translates :name, :attributes => { :allow_destroy => false }
    end
  end
end
