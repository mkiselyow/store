FactoryBot.define do
  factory :useful_article do
    title Faker::Pokemon.name
    body Faker::Lorem.paragraph
    user
  end
end
