# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  process resize_to_fill: [200, 200]

  version :thumb do
    process resize_to_fill: [64, 64]
  end

  def extension_white_list
    %w(jpg jpeg gif)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}_#{mounted_as}/#{model.id}"
  end
end