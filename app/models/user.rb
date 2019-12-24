class User < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :locations, as: :ownable, dependent: :destroy
  has_many :departments, as: :ownable, dependent: :destroy
  has_many :items, as: :ownable, dependent: :destroy
  has_many :assemblies, as: :ownable, dependent: :destroy
  has_many :orders, as: :ownable, dependent: :destroy
  has_many :meal_schedules, as: :ownable, dependent: :destroy

  # Include default devise modules. Others available are:
  # :lockable, and :omniauthable
  devise :invitable, :async, :confirmable, :async, :database_authenticatable, :async, :timeoutable, :trackable,
         :registerable, :async, :recoverable, :rememberable, :validatable

  # validates :username, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def clear_group_invitation
    self.invitation_sent_at = nil
    self.invitation_group_token = nil
    self.invitation_group_id = nil
  end

  def has_groups?
    self.groups.length > 0
  end

  def self.invite_existing_user_to_group(user, current_inviter)
    # TODO: this should be moved to an instance method, if possible
    User.generate_invitation_token!(user)
    ExistingUserGroupInviteMailer.group_invite(user, current_inviter).deliver_later
  end

  def self.remove_invitation_group_id_after_invitaion_acceptence(user)
    User.set_invitation_group_id!(user)
  end

  def self.set_invitation_group_id!(user, invitation_group_id = nil)
    return if user.nil?

    user.invitation_group_id = invitation_group_id
    user.save!
  end

  # copied this directly out of devise_invitable commit:
  # https://github.com/scambra/devise_invitable/commit/d479a8c98af3da4e1c05e772b559f590cc7df53f#diff-c4d29d16cf6c6cb74d6523498cd0d88f
  def self.generate_invitation_token!(user)
    user.invitation_group_token = Devise.friendly_token
    user.invitation_sent_at = Time.now.utc

    user.save!
  end
end
