class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, and :omniauthable
  devise :confirmable, :database_authenticatable, :timeoutable, :trackable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
