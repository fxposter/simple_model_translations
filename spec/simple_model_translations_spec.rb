require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Article do
  it { should have_many :translations }

  it "should have empty translations for a new record" do
    Article.new.translations.should be_empty
  end
  
  it 'should destroy dependent locales' do
    article = Article.create!(:slug => '__hello__', :name => 'Hello', :content => 'World')
    expect do
      article.destroy
    end.to change(ArticleTranslation, :count).by(-1)
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
  
  it "should create translation class automatically if it doesn't exists" do
    Tag.translation_class.should_not be_nil
    Tag.translation_class.table_name.should == 'tag_translations'
  end
end

describe ArticleTranslation do
  it { should belong_to :article }
end
