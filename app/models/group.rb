# frozen_string_literal: true

#
# id:           integer
# name:         string
# description:  string
# created_at:   datetime
# updated_a:    datetime
#
class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :locations, as: :ownable, dependent: :destroy
  has_many :departments, as: :ownable, dependent: :destroy
  has_many :items, as: :ownable, dependent: :destroy
  has_many :assemblies, as: :ownable, dependent: :destroy
  has_many :orders, as: :ownable, dependent: :destroy
  has_many :meal_schedules, as: :ownable, dependent: :destroy
  has_many :recipes, as: :ownable, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
