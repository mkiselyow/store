Cloudinary.config do |config|
  if Rails.env.development?
    config.cloud_name = ENV['cloudinary_name']
    config.api_key = ENV['cloud_api_key']
    config.api_secret = ENV['cloud_api_secret']
    config.enhance_image_tag = true
    config.static_image_support = false
  elsif Rails.env.production?
    config.cloud_name = ENV['cloudinary_name']
    config.api_key = ENV['cloud_api_key']
    config.api_secret = ENV['cloud_api_secret']
    config.enhance_image_tag = true
    config.static_image_support = false
  elsif Rails.env.test?
    config.cloud_name = ENV['cloudinary_name']
    config.api_key = ENV['cloud_api_key']
    config.api_secret = ENV['cloud_api_secret']
    config.enhance_image_tag = true
    config.static_image_support = false
  end
end
