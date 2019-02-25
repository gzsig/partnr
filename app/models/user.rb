class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :deals
  has_many :deal_preferences

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :CPF, presence: true, uniqueness: true
  validates :address, presence: true
  validates :bio, presence: true
  validates :phone_number, presence: true
  validates :occupation, presence: true

  def is_adm?
    self.adm
  end
end
