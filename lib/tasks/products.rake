require 'csv'

namespace :products do
  desc 'Export task should export all Products from database to CSV file'
  task export: :environment do
    CSV.open('products_export.csv', 'wb', headers: true) do |csv|
      csv << Product.attribute_names
      Product.all.each do |product|
        csv << product.attributes.values
      end
    end
  end
end
