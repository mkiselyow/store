SitemapGenerator::Sitemap.default_host = "http://www.mapapama.com.ua"

SitemapGenerator::Sitemap.create do
  add root_path, changefreq: 'daily'
  Category.find_each do |category|
    add category_path(category), :changefreq => 'weekly', :lastmod => category.updated_at
  
    category.products.each do |product|
      add category_path(category), :changefreq => 'yearly', :lastmod => product.updated_at
    end
  end
end
