Sex.create(name: 'Мальчики')
Sex.create(name: 'Девочки')
Sex.create(name: 'Унисекс')

Category.create(name: 'Одежда')
Category.create(name: 'Игрушки')

CategoryPost.create(name: 'Блог')

image_collection_for_faker = []
image_collection_for_faker << "image/upload/v1506689043/zabavka-treugolnik-s-kolechkami-masik-20170419211156-s_gl7w6w.jpg"
image_collection_for_faker << "image/upload/v1506689043/vedro-dlja-peska-zamok-sinee-tigres-20170418115907-s_duzjxg.jpg"
image_collection_for_faker << "image/upload/v1506689043/razvivajushhie-zadanija-pishi-i-vytiraj-ovechka-s-markerom-na-ukrainskom-jazyke-vladi-toys-20170919170323-s_j8oxgf.jpg"
image_collection_for_faker.each do |image|
  this_product = Product.create!(title: Faker::Pokemon.name, price: "33", purchase_price: Faker::Number.decimal(2), mark_up: Faker::Number.between(1, 9)*10, color_white: Faker::Boolean.boolean, brand: Faker::Company.name, material_plastic: Faker::Boolean.boolean, material_iron: Faker::Boolean.boolean, material_wooden: Faker::Boolean.boolean, material_fabric: Faker::Boolean.boolean, material_another: Faker::Boolean.boolean, quantity: Faker::Number.between(0, 44), sex_id: 1, description: Faker::Lorem.paragraph, country: Faker::Address.country, discount: Faker::Number.between(0, 3)*10, product_code: Faker::Number.unique.number(8), category_id: Category.first.id)
  this_product.update_column(:image, image)
end