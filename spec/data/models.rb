class Article < ActiveRecord::Base
  translates :name, :content, :class_name => 'ArticleTranslation'
end

class ArticleTranslation < ActiveRecord::Base
  translation_for :article
end

class Post < ActiveRecord::Base
  translates :name, :content
  validate_translations :en, :ru
end

class PostTranslation < ActiveRecord::Base
  translation_for :post
end

class Tag < ActiveRecord::Base
  translates :name
end