class UsefulArticle < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  has_many :comment_posts

  mount_uploader :preview, PreviewUploader
end
