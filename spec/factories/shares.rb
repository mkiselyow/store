FactoryBot.define do
  factory :share do
    title Faker::Pokemon.name
    body Faker::Lorem.paragraph
    poster { [File.new(Rails.root.join('spec', 'fixtures', 'images', 'test.jpg')), nil].sample }
    user
  end
end
