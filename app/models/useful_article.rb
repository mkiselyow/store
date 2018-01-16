class UsefulArticle < ApplicationRecord
  belongs_to :category_post
  belongs_to :user, optional: true
  has_many :comment_posts, dependent: :destroy

  mount_uploader :preview, PreviewUploader

  scope :only_published, -> { where(published: true) }

  self.per_page = 10
end
