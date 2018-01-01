class Share < ApplicationRecord
  belongs_to :user
  mount_uploader :poster, PosterUploader

  scope :last_five_offers, -> { order('id DESC').limit(5) }
end
