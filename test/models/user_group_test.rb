# == Schema Information
#
# Table name: user_groups
#
#  id                  :bigint           not null, primary key
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  management_group_id :bigint           not null
#
# Indexes
#
#  index_user_groups_on_management_group_id  (management_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (management_group_id => management_groups.id)
#
require "test_helper"

class UserGroupTest < ActiveSupport::TestCase
  
  test "name attribute exists" do
    name = user_groups(:one).name

    assert_instance_of String, name
  end

  test "management_group association exists" do
    management_group = user_groups(:one).management_group

    assert_instance_of ManagementGroup, management_group
  end

  test "users association exists" do
    user = user_groups(:one).users.first

    assert_instance_of User, user
  end

  test "user_group_rentals association exists" do
    user_group_rental = user_groups(:one).user_group_rentals.first

    assert_instance_of UserGroupRental, user_group_rental
  end

  test "rentals association exists" do
    rental = user_groups(:one).rentals.first

    assert_instance_of Rental, rental
  end
end
