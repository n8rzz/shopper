=begin

id:           integer
name:         string
description:  string
created_at:   datetime
updated_a:    datetime

=end
class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  validates :name, presence: true, uniqueness: true
end
