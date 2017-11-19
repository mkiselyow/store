class CommentPost < ApplicationRecord
  belongs_to :useful_article
  belongs_to :user
end
