FactoryBot.define do
  factory :comment do
    title Faker::Pokemon.name
    body Faker::Lorem.paragraph
    user
  end
end
