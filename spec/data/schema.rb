ActiveRecord::Migration.verbose = false

ActiveRecord::Schema.define do
  create_table :articles, :force => true do |t|
    t.string :slug
  end

  create_table :article_translations, :force => true do |t|
    t.string :locale
    t.references :article
    t.string :name
    t.text :content
  end
  
  create_table :posts, :force => true do |t|
    t.string :slug
  end

  create_table :post_translations, :force => true do |t|
    t.string :locale
    t.references :post
    t.string :name
    t.text :content
  end
  
  create_table :tags, :force => true do |t|
  end

  create_table :tag_translations, :force => true do |t|
    t.string :locale
    t.references :tag
    t.string :name
  end
  
  create_table :categories, :force => true
  create_table :category_translations, :force => true do |t|
    t.string :locale
    t.references :category
    t.string :name
  end
  
  create_table :some_models, :force => true
  create_table :some_model_translations, :force => true do |t|
    t.string :locale
    t.references :some_models
    t.string :name
  end
end

