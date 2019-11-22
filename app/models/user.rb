class User < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups

  # Include default devise modules. Others available are:
  # :lockable, and :omniauthable
  devise :confirmable, :database_authenticatable, :timeoutable, :trackable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def has_groups?
    self.groups.length > 0
  end
end
