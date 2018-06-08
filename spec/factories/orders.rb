FactoryBot.define do
  factory :order do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    number Faker::Number.number(8)
    sequence(:email) { |n| "user#{n}@example.com" }
    city Faker::Address.city
    post_office_number Faker::Address.zip_code
    pay_type Order::PAYMENT_TYPES.sample
    way_delivery Order::DELIVERY_TYPES.sample
    user

    trait :with_line_items do
      after(:create) do |order|
        FactoryBot.create(:line_item, order: order)
      end
    end
  end
end
