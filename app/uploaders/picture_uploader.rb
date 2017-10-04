class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process resize_to_fill(500, 500)

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
