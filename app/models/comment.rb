class Comment < ApplicationRecord
  belongs_to :user

  # def average_rating
  #   ratings.sum(:score) / ratings.size
  # end
end
