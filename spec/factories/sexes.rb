FactoryBot.define do
  factory :sex do
    name ['Male', 'Female', 'Unisex'].sample
  end
end
