class UserView < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :user_id, uniqueness: { scope: :product_id }

  scope :last_six_views, -> { order('updated_at DESC').limit(6) }
end
