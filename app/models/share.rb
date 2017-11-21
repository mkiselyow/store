class Share < ApplicationRecord
  belongs_to :user
  mount_uploader :poster, PosterUploader
end
