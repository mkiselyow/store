SitemapGenerator::Sitemap.default_host = "http://www.mapapama.com.ua"

SitemapGenerator::Sitemap.create do
  add products_path, priority: 0.5, changefreq: 'daily'
  add categories_path, priority: 0.5, changefreq: 'daily'
  add about_path, priority: 0.5, changefreq: 'daily'
  add contacts_path, priority: 0.5, changefreq: 'daily'
  add delivery_path, priority: 0.5, changefreq: 'daily'
  add payment_path, priority: 0.5, changefreq: 'daily'
  # Category.find_each do |category|
  #   add category_path(category), :changefreq => 'weekly', :lastmod => category.updated_at
  
  #   category.products.each do |product|
  #     add category_path(category), :changefreq => 'yearly', :lastmod => product.updated_at
  #   end
  # end
  # Product.find_each do |product|
  #   add product_path(product), :changefreq => 'weekly', :lastmod => product.updated_at
  # end
end
