class UsefulArticle < ApplicationRecord
  belongs_to :user
  mount_uploader :preview, PreviewUploader
  has_many :comment_posts
end
