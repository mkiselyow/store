class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => 'png'
  process :tags => ['post_picture']
  
  version :standard do
    process :resize_to_fill => [100, 100, :north]
  end
  
  version :thumbnail do
    resize_to_fit(50, 50)
  end

  version :gray do
    process :resize_to_fill => [100, 150, :north]
    # process :to_grey
    cloudinary_transformation :effect => "grayscale"
  end
end
