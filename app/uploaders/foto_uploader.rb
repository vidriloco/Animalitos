# encoding: utf-8

class FotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [150, 150, Magick::CenterGravity]
  end
  
  version :thumbje do
    process :resize_to_fill => [130, 130, Magick::CenterGravity]
  end
  
  version :frente do
    process :resize_to_fill => [220, 220, Magick::CenterGravity]
  end

  process :scale => 0.25

  def scale(byFactor)
    manipulate! do |img|
      if(img.rows > 800 || img.columns > 900)
        img = img.scale!(byFactor)
      end
      img
    end
  end

   # Add a white list of extensions which are allowed to be uploaded.
   # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end

end
