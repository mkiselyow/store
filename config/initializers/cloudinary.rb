Cloudinary.config do |config|
  if Rails.env.development?
    config.cloud_name = "dapc2mxjl"
    config.api_key = '816189238925946'
    config.api_secret = 'xQs9nIUulMx6QNkGmzQOdhVg2_s'
    config.enhance_image_tag = true
    config.static_image_support = false
  elsif Rails.env.production?
    config.cloud_name = "hfy83q30e"
    config.api_key = '994467127933574'
    config.api_secret = '3fON5atyTpl9uUGZVHXqlFjh-jQ'
    config.enhance_image_tag = true
    config.static_image_support = false
  elsif Rails.env.test?
    config.cloud_name = "dapc2mxjl"
    config.api_key = '816189238925946'
    config.api_secret = 'xQs9nIUulMx6QNkGmzQOdhVg2_s'
    config.enhance_image_tag = true
    config.static_image_support = false
  end
end