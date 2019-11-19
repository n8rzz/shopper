class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :timeoutable, :trackable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
end
