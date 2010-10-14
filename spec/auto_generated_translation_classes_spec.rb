require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Tag do
  it "should be" do
    tag = Tag.create!(:locale => :en, :name => 'hello')
    tag.name = 'hello, ukraine!'
    tag.reload
    tag.name.should be_nil
    I18n.locale = :en
    tag.name.should == 'hello'
  end
  
  it "should create translation class automatically if it doesn't exists" do
    Tag.translation_class.should_not be_nil
    Tag.translation_class.table_name.should == 'tag_translations'
  end
end
