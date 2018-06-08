FactoryBot.define do
  factory :comment_post do
    title Faker::Pokemon.name
    body Faker::Lorem.paragraph
    useful_article
    user
  end
end
