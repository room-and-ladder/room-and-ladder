class ManagementGroup < ApplicationRecord
  has_many :rentals, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :user_group_rentals, through: :user_groups
  has_many :users, through: :user_groups
  has_many :properties
  has_many :rentals, through: :properties
end
