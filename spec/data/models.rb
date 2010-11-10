class ArticleTranslation < ActiveRecord::Base
  translation_for :article
end

class Article < ActiveRecord::Base
  translates :name, :content, :class_name => 'ArticleTranslation'
end

class PostTranslation < ActiveRecord::Base
  translation_for :post
end

class Post < ActiveRecord::Base
  translates :name, :content
  validate_translations :en, :ru
end

class Tag < ActiveRecord::Base
  translates :name
end

class Category < ActiveRecord::Base
  translates :name, :attributes => true
end
