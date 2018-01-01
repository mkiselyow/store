class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url
    [thumb, 'default_user.png'].compact.join('_')
  end

  process tags: ['photo_album_sample']
  process convert: 'jpg'

  version :thumb do
    eager
    resize_to_fit(200, 200)
    cloudinary_transformation quality: 80
  end

  version :small do
    eager
    resize_to_fit(50, 50)
    cloudinary_transformation quality: 80
  end

  version :medium do
    eager
    resize_to_fit(400, 400)
    cloudinary_transformation quality: 80
  end

  version :large do
    eager
    resize_to_fit(800, 800)
    cloudinary_transformation quality: 80
  end
end
