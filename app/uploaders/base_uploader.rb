class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  process :resize_to_fill => [870, 652]

  version :middle do
    process :resize_to_fill => [400, 300]
  end

  version :small do
    process :resize_to_fill => [240, 180]
  end

  version :thumb do
    process :resize_to_fill => [100, 75]
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end 