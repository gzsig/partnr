class Partner < ApplicationRecord
  belongs_to :user
  belongs_to :good

  validates :user, uniqueness: { scope: :good }
  validates :numberber_of_passengers, numericality: true, if: -> { numberber_of_passengers.present? }
  validates :km_month, numericality: { only_integer: true }, if: -> { km_month.present? }
  validates :frenquency_month, numericality: { only_integer: true }, if: -> { frenquency_month.present? }

  enum step: { not_set: 0, notified: 1, confirmed: 2, signed: 3 }
end
