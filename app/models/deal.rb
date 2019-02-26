class Deal < ApplicationRecord
  belongs_to :car
  has_many :deal_users
  has_many :users, through: :deal_users
end
