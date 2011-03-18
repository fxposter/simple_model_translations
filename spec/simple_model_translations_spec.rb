require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Article do
  after { I18n.locale = I18n.default_locale }
  
  it { should have_many :translations }

  it "should have empty translations for a new record" do
    Article.new.translations.should be_empty
  end
  
  it 'should destroy dependent locales' do
    article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
    expect { article.destroy }.to change(ArticleTranslation, :count).by(-1)
  end
  
  it 'should use I18n fallbacks' do
    article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
    article.update_attributes! :locale => :en, :name => 'Hello in English'
    I18n.locale = :en
    article.name.should == 'Hello in English'
    I18n.locale = :ru
    article.name.should == 'Hello'
    I18n.locale = :de
    article.name.should == 'Hello'
  end
  
  describe '#current_translation' do
    it 'should return translation for current locale if it exists' do
      article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
      article.translation_helper.current_translation.should == article.translations.find_by_locale(I18n.locale)
    end
    
    it 'should return translation for default locale if translation for current locale does not exist' do
      article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
      I18n.locale = :de
      article.translation_helper.current_translation.should == article.translations.find_by_locale(I18n.default_locale)
    end
    
    it 'should return nil if translations for current and default locales do not exist' do
      article = Article.create!(:slug => '__hello__')
      article.translation_helper.current_translation.should be_nil
    end
  end
  
  describe '#force_translation_with_locale(locale)' do
    it 'should use data from selected translation' do
      article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World', :locale => :en)
      article.update_attributes!(:name => 'Привет', :locale => :ru)
      article.translation_helper.force_translation_with_locale(:en)
      article.content.should == 'World'
      article.name.should == 'Hello'
    end
    
    it 'should raise exception when there is no translation' do
      article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
      expect { article.translation_helper.force_translation_with_locale(:en) }.to raise_error
    end
    
    it 'should make record read-only' do
      article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World', :locale => :en)
      article.update_attributes!(:name => 'Привет', :locale => :ru)
      article.translation_helper.force_translation_with_locale(:en)
      article.should be_readonly
    end
    
  end
end

describe ArticleTranslation do
  it { should belong_to :article }
  
  it 'always has an article' do
    article = Article.new(:name => 'hello')
    article.translations.first.article.should == article
  end
end
