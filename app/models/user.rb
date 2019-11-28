class User < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :locations, as: :ownable, dependent: :destroy
  has_many :departments, as: :ownable, dependent: :destroy

  # Include default devise modules. Others available are:
  # :lockable, and :omniauthable
  devise :invitable, :confirmable, :database_authenticatable, :timeoutable, :trackable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :username, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def has_groups?
    self.groups.length > 0
  end

  def self.remove_invitation_group_id_after_invitaion_acceptence(user)
    return if user.invitation_group_id == nil

    user.invitation_group_id = nil
    user.save!
  end
end
