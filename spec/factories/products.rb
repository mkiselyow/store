FactoryBot.define do
  factory :product do
    title Faker::Pokemon.name
    price Faker::Number.decimal(2)
    purchase_price Faker::Number.decimal(2)
    mark_up Faker::Number.between(1, 9)*10
    color_white Faker::Boolean.boolean
    brand Faker::Company.name
    material_plastic Faker::Boolean.boolean
    material_iron Faker::Boolean.boolean
    material_wooden Faker::Boolean.boolean
    material_fabric Faker::Boolean.boolean
    material_another Faker::Boolean.boolean
    quantity Faker::Number.between(0, 44)
    sex_id Faker::Number.between(1, 3)
    description Faker::Lorem.paragraph
    country Faker::Address.country
    discount Faker::Number.between(0, 3)*10
    product_code Faker::Number.unique.number(8)
    category
    sex
  end
end
