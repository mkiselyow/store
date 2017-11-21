class PosterUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['post_picture']

  def default_url
    [thumb, 'default_image.png'].compact.join('_')
  end
  
  version :standard do
    process :resize_to_fill => [100, 100, :north]
  end
  
  version :thumbnail do
    resize_to_fit(50, 50)
  end

  version :thumb do
    eager
    resize_to_fit(200, 200)
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

  version :big_large do
    eager
    resize_to_fit(1280, 720)
    cloudinary_transformation quality: 80
  end

  version :gray do
    process :resize_to_fill => [100, 150, :north]
    # process :to_grey
    cloudinary_transformation :effect => "grayscale"
  end

end
