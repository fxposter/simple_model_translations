require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Post do
  it 'should be valid with both :ru and :en translations' do
    post = Post.new(:locale => :ru, :name => 'Privet')
    post.attributes = { :locale => :en, :name => 'Hello' }
    post.should be_valid
  end
  
  it 'should be invalid with only :ru translation' do
    post = Post.new(:locale => :ru, :name => 'Privet')
    post.should_not be_valid
  end
end
