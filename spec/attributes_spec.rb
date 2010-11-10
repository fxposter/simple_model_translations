# encoding: UTF-8

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Article do
  describe '#create with locale' do
    before do
      @article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World', :locale => :en)
    end
    
    it 'should create corresponding translation' do
      @article.should have_translation(:en)
      @article.translations.count.should == 1
    end
  
    it 'should assign attributes to translation' do
      @article.should have_translated_attribute(:en, :name, 'Hello')
      @article.should have_translated_attribute(:en, :content, 'World')
    end
    
    it 'should assign non-translated attributes to model itself' do
      @article.slug.should == '__hello__'
    end
  end
  
  describe '#create without locale' do
    before do
      I18n.locale = :ru
      @article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
    end
    
    it 'should create corresponding translation' do
      @article.should have_translation(:ru)
      @article.translations.count.should == 1
    end
  
    it 'should assign attributes to translation' do
      @article.should have_translated_attribute(:ru, :name, 'Hello')
      @article.should have_translated_attribute(:ru, :content, 'World')
    end
    
    it 'should assign non-translated attributes to model itself' do
      @article.slug.should == '__hello__'
    end
  end
  
  describe '#update_attributes' do
    before do
      I18n.locale = :ru
      @article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
      @article.update_attributes! :locale => :en, :name => 'Hello in English'
    end
    
    it 'should create corresponding translation' do
      @article.should have_translation(:ru)
      @article.should have_translation(:en)
      @article.translations.length.should == 2
    end
  
    it 'should assign attributes to translation' do
      @article.should have_translated_attribute(:ru, :name, 'Hello')
      @article.should have_translated_attribute(:en, :name, 'Hello in English')
    end
  end
  
  describe '#attributes=' do
    before do
      I18n.locale = :ru
      @article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
      @article.attributes = { :locale => :en, :name => 'Hello in English' }
    end
    
    it 'should create corresponding translation' do
      @article.should have_translation(:ru)
      @article.should have_translation(:en)
      @article.translations.length.should == 2
    end
  
    it 'should assign attributes to translation' do
      @article.should have_translated_attribute(:ru, :name, 'Hello')
      @article.should have_translated_attribute(:en, :name, 'Hello in English')
    end
  end
  
  it 'should proxy #attribute= methods to translations' do
    article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
    article.name = 'Hi'
    article.should have_translated_attribute(:ru, :name, 'Hi')
  end
  
  it 'should proxy #attribute methods to translations' do
    article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
    article.name.should == 'Hello'
  end
end

describe ArticleTranslation do
  it { should belong_to :article }
end

describe Category do
  it { should respond_to(:translations_attributes=) }
  it 'should accept array of translation attributes' do
    category = Category.create!(:translations_attributes => [
                  { :locale => :en, :name => 'Science' },
                  { :locale => :ru, :name => 'Наука' }
                ])
    category.should have_translation(:ru)
    category.should have_translation(:en)
    category.should have_translated_attribute(:en, :name, 'Science')
    category.should have_translated_attribute(:ru, :name, 'Наука')
  end
end

