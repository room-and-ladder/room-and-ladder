class UserGroup < ApplicationRecord
  belongs_to :management_group
  has_many :users
  has_many :user_group_rentals,  dependent: :delete_all
  has_many :rentals,  through: :user_group_rentals
end
