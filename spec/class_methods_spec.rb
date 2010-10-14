require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Article do
  it 'should be able to return only records which have translations' do
    first_article = Article.create!(:slug => 'hello')
    second_article = Article.create!(:slug => 'world', :name => 'WORLD')
    Article.with_translations.to_a.should == [second_article]
  end
  
  it 'should be able to return translation class' do
    Article.translation_class.should == ArticleTranslation
  end
  
  it 'should be able to return translated column name' do
    Article.translated_column_name(:name).should == :'article_translations.name'
  end
  
  it 'should be able to search by specific column names and locales' do
    first_article = Article.create!(:slug => 'hello', :locale => :en, :name => 'hello')
    second_article = Article.create!(:slug => 'world', :name => 'WORLD')
    third_article = Article.create!(:slug => 'hello')
    fourth_article = Article.create!(:slug => 'world', :name => 'WORLD', :locale => :en)
    Article.with_translated_attribute(:name, ['hello'], :en).should == [first_article]
  end
end
