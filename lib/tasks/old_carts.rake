namespace :delete do
  desc 'Delete carts older than 1 day'
  task old_carts: :environment do
    Cart.where('created_at < ?', 1.day.ago).each do |cart|
      cart.destroy
    end
  end
end
