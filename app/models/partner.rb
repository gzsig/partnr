class Partner < ApplicationRecord
  belongs_to :user
  belongs_to :good
end
