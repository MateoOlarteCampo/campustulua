class ArticlePictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick



  storage :file

  # for image size validation
  # fetching dimensions in uploader, validating it in model
  attr_reader :width, :height
  before :cache, :capture_size
  def capture_size(file)
    if version_name.blank? # Only do this once, to the original version
      if file.path.nil? # file sometimes is in memory
        img = ::MiniMagick::Image::read(file.file)
        @width = img[:width]
        @height = img[:height]
      else
        @width, @height = `identify -format "%wx %h" #{file.path}`.split(/x/).map{|dim| dim.to_i }
      end
    end
  end
  
  process resize_to_fill: [1400,500]

  version :thumb do
    process resize_to_fill: [500,200]
  end

  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def extension_whitelist
     %w(jpg jpeg gif png)
  end

  

end
