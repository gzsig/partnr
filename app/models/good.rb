class Good < ApplicationRecord
  has_many :partners

  mount_uploader :photo_one, PhotoUploader
  mount_uploader :photo_two, PhotoUploader
  mount_uploader :photo_three, PhotoUploader
  mount_uploader :photo_four, PhotoUploader
  mount_uploader :video, PhotoUploader

  def set_status
    unless self.partners.count < 4
      self.status = true
    end
  end
end
