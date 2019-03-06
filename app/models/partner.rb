class Partner < ApplicationRecord
  belongs_to :user
  belongs_to :good

  validates :user, uniqueness: { scope: :good }
  enum step: { not_set: 0, notified: 1, confirmed: 2, signed: 3 }
end
