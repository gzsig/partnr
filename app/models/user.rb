class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :partners
  has_many :goods, through: :partners

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :CPF, presence: true, uniqueness: true
  validates :address, presence: true
  validates :bio, presence: true
  validates :phone_number, presence: true
  validates :occupation, presence: true

  mount_uploader :profile_picture, PhotoUploader

end
