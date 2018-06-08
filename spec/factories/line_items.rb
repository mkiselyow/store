FactoryBot.define do
  factory :line_item do
    quantity Faker::Number.between(1, 5)
    product
    cart
    order
  end
end
