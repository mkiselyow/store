class UsefulArticle < ApplicationRecord
  belongs_to :user
  mount_uploader :preview, PreviewUploader
end
