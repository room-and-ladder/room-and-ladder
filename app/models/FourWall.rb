# == Schema Information
#
# Table name: four_walls
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  real_property_id :bigint           not null
#
# Indexes
#
#  index_four_walls_on_real_property_id  (real_property_id)
#
# Foreign Keys
#
#  fk_rails_...  (real_property_id => real_properties.id)
#
class FourWall < ApplicationRecord
  belongs_to :real_property

  has_many :rentals
  has_many :utility_groups
  has_many :user_group_rentals, through: :rentals
  has_many :chores, through: :user_group_rentals
end
