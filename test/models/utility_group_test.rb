# == Schema Information
#
# Table name: utility_groups
#
#  id            :bigint           not null, primary key
#  date          :datetime
#  property_wide :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  four_wall_id  :bigint           not null
#
# Indexes
#
#  index_utility_groups_on_four_wall_id  (four_wall_id)
#
# Foreign Keys
#
#  fk_rails_...  (four_wall_id => four_walls.id)
#
require "test_helper"

class UtilityGroupTest < ActiveSupport::TestCase
  setup do
    @utility_group = utility_groups(:one)
  end

  test "many utility_splits association exists" do
    utility_split = @utility_group.utility_splits.first

    assert_instance_of UtilitySplit, utility_split
  end

  test "many utility_items association exists" do
    utility_item = @utility_group.utility_items.first

    assert_instance_of UtilityItem, utility_item
  end

  test "four_wall association exists" do
    four_wall = @utility_group.four_wall

    assert_instance_of FourWall, four_wall
  end

  test "date attribute exists" do
    date = @utility_group.date

    assert_instance_of ActiveSupport::TimeWithZone, date
  end

  test "property_wide attribute exists" do
    property_wide = @utility_group.property_wide

    assert_instance_of FalseClass, property_wide
  end
end
