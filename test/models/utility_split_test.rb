# == Schema Information
#
# Table name: utility_splits
#
#  id                   :bigint           not null, primary key
#  occupancy_duration   :interval
#  split_charge         :integer
#  split_points         :integer
#  split_rate           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#  utility_group_id     :bigint           not null
#
# Indexes
#
#  index_utility_splits_on_user_group_rental_id  (user_group_rental_id)
#  index_utility_splits_on_utility_group_id      (utility_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#  fk_rails_...  (utility_group_id => utility_groups.id)
#
require "test_helper"

class UtilitySplitTest < ActiveSupport::TestCase
  setup do
    @utility_split = utility_splits(:one)
  end

  test "user_group_rental association exists" do
    user_group_rental = @utility_split.user_group_rental

    assert_instance_of UserGroupRental, user_group_rental
  end

  test "utility_group association exists" do
    utility_group = @utility_split.utility_group

    assert_instance_of UtilityGroup, utility_group
  end

  test "split_rate attribute exists" do
    split_rate = @utility_split.split_rate

    assert_instance_of Integer, split_rate
  end

  test "occupancy_duration attribute exists" do
    @utility_split.update_attribute! :occupancy_duration, 2.days
    occupancy_duration = @utility_split.occupancy_duration

    assert_instance_of ActiveSupport::Duration, occupancy_duration
  end

  test "split_points attribute exists" do
    split_points = @utility_split.split_points

    assert_instance_of Integer, split_points
  end

  test "split_charge attribute exists" do
    split_charge = @utility_split.split_charge

    assert_instance_of Integer, split_charge
  end
end
