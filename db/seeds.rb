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
image_collection_for_faker << "image/upload/v1506689043/rasprodazha-konstruktor-spasateli-240-detalej-oroanzhevyj-best-lock-20170421150719-s_tswijj.jpg"
image_collection_for_faker << "image/upload/v1506689043/pogremushka-cvetnye-shariki-canpol-babies-20170419133454-s_hkbcgd.jpg"
image_collection_for_faker << "image/upload/v1506689042/rasprodazha-igrushka-volshebnaja-loshadka-rokki-babybaby-20160924144443-s_uaz5nn.jpg"
image_collection_for_faker << "image/upload/v1506689042/plakat-ukrainskij-alfavit-izdatelstvo-zvezda-20170421182420-s_faijis.jpg"
image_collection_for_faker << "image/upload/v1506689042/obnimashka-zajka-spljusha-masik-20170421182417-s_g5yqwu.jpg"
image_collection_for_faker << "image/upload/v1506689042/nastolnaja-igra-zmejki-i-lesenki-arial-20170419163042-s_rxyjzu.jpg"
image_collection_for_faker << "image/upload/v1506689042/nastolnaja-igra-objasni-slovo-veselaja-logika-arial-20170421032000-s_jseccp.jpg"
image_collection_for_faker << "image/upload/v1506689041/nastolnaja-igra-krokodil-arial-20170420100908-s_ita4rp.jpg"
image_collection_for_faker << "image/upload/v1506689041/nabor-mnogorazovyh-nakleek-mesta-obitanija-zhivotnyh-melissa-doug-20170420165951-s_ayt6sq.jpg"
image_collection_for_faker << "image/upload/v1506689041/nabor-igrushek-dlja-vanny-lodochki-baby-team-20170421000354-s_sjebxl.jpg"
image_collection_for_faker << "image/upload/v1506689041/nabor-formochek-dlja-peska-deex-20170421092226-s_rjun0b.jpg"
image_collection_for_faker << "image/upload/v1506689041/nabor-dinozavry-7sm-6sht-wing-crown-20170419093426-s_lrt2fc.jpg"
image_collection_for_faker << "image/upload/v1506689041/muzykalnaja-igrushka-veseloe-pianino-huile-toys-20161221155942-s_vfgwyd.jpg"
image_collection_for_faker << "image/upload/v1506689041/mjagkaja-igrushka-my-little-pony-raduga-djesh-ty-toys-20170420161138-s-1_s0oqdx.jpg"
image_collection_for_faker << "image/upload/v1506689041/kukla-perchatka-medved-chudisam-20170420004947-s_c7gklk.jpg"
image_collection_for_faker << "image/upload/v1506689041/igrushka-dlja-koljaski-i-avtokresla-kotenok-babyono-20170421023337-s_s8fw2w.jpg"
image_collection_for_faker << "image/upload/v1506689041/igra-mama-i-malysh-djeco-20170420064057-s_x6gglf.jpg"
image_collection_for_faker << "image/upload/v1506689040/derevjannye-schety-slozhenie-i-vychitanie-melissadoug-20170421175814-s_srbesj.jpg"
image_collection_for_faker << "image/upload/v1506689040/chubakka-75529-lego-star-wars-20170831112125-s_rckz95.jpg"
image_collection_for_faker << "image/upload/v1506689040/avtomodel-bmw-m5-uni-fortune-20170420153221-s-1_srkki5.jpg"
image_collection_for_faker << "image/upload/v1506689040/avtomodel-avtobus-belo-zelenyj-tehnopark-20170421155854-s_na0y4u.jpg"
image_collection_for_faker << "image/upload/v1506689040/akva-pazly-bathn-puzzles-kinderenok-20170419222220-s_vtu23n.jpg"
image_collection_for_faker << "image/upload/v1506689040/331-0095-20170803142708-20170803142708-s_cj2kyz.jpg"
image_collection_for_faker.each do |image|
  this_product = Product.create!(title: Faker::Pokemon.name, price: "33", purchase_price: Faker::Number.decimal(2), mark_up: Faker::Number.between(1, 9)*10, color_white: Faker::Boolean.boolean, brand: Faker::Company.name, material_plastic: Faker::Boolean.boolean, material_iron: Faker::Boolean.boolean, material_wooden: Faker::Boolean.boolean, material_fabric: Faker::Boolean.boolean, material_another: Faker::Boolean.boolean, quantity: Faker::Number.between(0, 44), sex_id: 1, description: Faker::Lorem.paragraph, country: Faker::Address.country, discount: Faker::Number.between(0, 3)*10, product_code: Faker::Number.unique.number(8), category_id: Category.first.id)
  this_product.update_column(:image, image)
end