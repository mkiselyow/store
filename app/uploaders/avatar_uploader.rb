class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    [thumb, 'default_user.png'].compact.join('_')
  end

  version :thumb do
    resize_to_fit(200, 200)
  end

  version :small do
    resize_to_fit(50, 50)
  end

  version :medium do
    resize_to_fit(400, 400)
  end

  version :large do
    resize_to_fit(800, 800)
  end
end
