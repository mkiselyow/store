class CategoryPost < ApplicationRecord
  has_many :useful_articles, dependent: :destroy
end
