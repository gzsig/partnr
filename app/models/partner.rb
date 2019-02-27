class Partner < ApplicationRecord
  belongs_to :user
  belongs_to :good

  validates :user, uniqueness: { scope: :good }
end
