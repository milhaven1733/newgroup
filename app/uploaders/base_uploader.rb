class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  
  process :resize_to_fit => [800, 800]
  
  version :middle do
    process :resize_to_fit => [300, 300]
  end

  version :thumb do
    process :resize_to_fit => [100, 100]
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end 