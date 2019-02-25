class Deal < ApplicationRecord
  has_one :car
  belongs_to :user_1, class_name: 'User'
  belongs_to :user_2, class_name: 'User'
  belongs_to :user_3, class_name: 'User'
  belongs_to :user_4, class_name: 'User'
end
