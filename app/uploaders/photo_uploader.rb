class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  process :resize_to_fill => [300, 300]

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    'uploads/photos'
  end

end