class Deal < ApplicationRecord
  belongs_to :car
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'
  belongs_to :user_3, class_name: 'User'
  belongs_to :user_4, class_name: 'User'
  has_many :deal_preferences
end
