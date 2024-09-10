# == Schema Information
#
# Table name: management_groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ManagementGroup < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :user_group_rentals, through: :user_groups
  has_many :users, through: :user_groups
  has_many :real_properties
  has_many :four_walls, through: :real_properties
  has_many :rentals, through: :four_walls
end
