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
require "test_helper"

class FourWallTest < ActiveSupport::TestCase
  test "name attribute exists" do
    name = four_walls(:one).name

    assert_instance_of String, name
  end


  test "real_property association exists" do
    real_property = four_walls(:one).real_property

    assert_instance_of RealProperty, real_property
  end

  test "many rentals association exists" do
    rental = four_walls(:one).rentals.first

    assert_instance_of Rental, rental
  end

  test "many utility_groups association exists" do
    utility_group = four_walls(:one).utility_groups.first

    assert_instance_of UtilityGroup, utility_group
  end

  test "many user_group_rentals association exists" do
    user_group_rental = four_walls(:one).user_group_rentals.first

    assert_instance_of UserGroupRental, user_group_rental
  end

  test "many chores association exists" do
    chore = four_walls(:one).chores.first

    assert_instance_of Chore, chore
  end
end
