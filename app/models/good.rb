class Good < ApplicationRecord
  has_many :partners
  has_many :users, through: :partners

  # cloudnary uploads
  mount_uploader :photo_one, PhotoUploader
  mount_uploader :photo_two, PhotoUploader
  mount_uploader :photo_three, PhotoUploader
  mount_uploader :photo_four, PhotoUploader
  mount_uploader :video, PhotoUploader

  # search goods by [brand, model]
  include PgSearch
  pg_search_scope :search_by_brand_and_model,
                  against: %i[brand model],
                  using: {
                    tsearch: { prefix: true }
                  }

  # set good status to true as soon as numebr of partner > 4
  def set_status
    unless self.partners.count < 4
      self.status = true
    end
  end

  # def ask_colors
  #   Good.order(color: :asc).pluck(:color).uniq
  # end

  # def oldest fabrication year (to build year range @ view level)
  def self.oldest_good_fabrication_year
    Good.order(fabrication_year: :asc).first.fabrication_year
  end

  # def min and max prices within our db (to build price range @ view level)
  def self.min_good_price
    Good.order(price: :asc).pluck(:price).first
  end

  def self.max_good_price
    Good.order(price: :asc).pluck(:price).last
  end

  # def all good types within our db (to build price range @ view level)
  def self.good_types
    Good.all.pluck(:good_type).uniq
  end

  # def all
end
