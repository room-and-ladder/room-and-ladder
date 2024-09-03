class FourWall < ApplicationRecord
  belongs_to :real_property

  has_many :rentals
  has_many :utility_groups

  has_many :user_rental_groups, through: :rentals
  has_many :chores, through: :user_rental_groups
end
