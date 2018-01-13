class UsefulArticle < ApplicationRecord
  belongs_to :category_post
  belongs_to :user
  has_many :comment_posts, dependent: :destroy

  mount_uploader :preview, PreviewUploader

  scope :only_published, -> { where(published: true) }
end
