class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    [thumb, 'default_image.png'].compact.join('_')
  end

  version :standard do
    process resize_to_fill: [100, 100, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end

  version :thumb do
    resize_to_fit(200, 200)
  end

  version :medium do
    resize_to_fit(400, 400)
  end

  version :large do
    resize_to_fit(800, 800)
  end

  version :big_large do
    resize_to_fit(1280, 720)
  end

  version :gray do
    process resize_to_fill: [100, 150, :north]
  end
end
