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
end

