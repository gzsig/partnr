class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  # Remove everything else

  process eager: true  # Force version generation at upload time.

process convert: 'jpg'

version :thumnail do
  resize_to_fit 150, 150
end

version :bright_face do
  cloudinary_transformation effect: "brightness:5", radius: 20,
    width: 150, height: 150, crop: :thumb, gravity: :face
end
end
