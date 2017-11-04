class Comment < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  # def average_rating
  #   ratings.sum(:score) / ratings.size
  # end
end
