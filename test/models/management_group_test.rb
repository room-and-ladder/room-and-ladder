# == Schema Information
#
# Table name: management_groups
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ManagementGroupTest < ActiveSupport::TestCase
  test "name attribute exists" do
    name = management_groups(:one).name

    assert_instance_of String, name
  end

  test "many rentals association exists" do
    rental = management_groups(:one).rentals.first

    assert_instance_of Rental, rental
  end
  test "many user_groups association exists" do
    user_group = management_groups(:one).user_groups.first

    assert_instance_of UserGroup, user_group
  end
  test "many user_group_rentals association exists" do
    user_group_rental = management_groups(:one).user_group_rentals.first

    assert_instance_of UserGroupRental, user_group_rental
  end
  test "many users association exists" do
    user = management_groups(:one).users.first

    assert_instance_of User, user
  end
  test "many real_properties association exists" do
    real_property = management_groups(:one).real_properties.first

    assert_instance_of RealProperty, real_property
  end
  test "many four_walls association exists" do
    four_wall = management_groups(:one).four_walls.first

    assert_instance_of FourWall, four_wall
  end
end
