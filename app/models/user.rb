class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :deal_users
  has_many :deals, through: :deal_users

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :CPF, presence: true, uniqueness: true
  validates :address, presence: true
  validates :bio, presence: true
  validates :phone_number, presence: true
  validates :occupation, presence: true

end
