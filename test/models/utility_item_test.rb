# == Schema Information
#
# Table name: utility_items
#
#  id               :bigint           not null, primary key
#  deffered         :boolean          default(FALSE), not null
#  kind             :enum             not null
#  total            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  utility_group_id :bigint           not null
#
# Indexes
#
#  index_utility_items_on_kind_and_utility_group_id  (kind,utility_group_id) UNIQUE
#  index_utility_items_on_utility_group_id           (utility_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (utility_group_id => utility_groups.id)
#
require "test_helper"

class UtilityItemTest < ActiveSupport::TestCase
  setup do
    @utility_item = utility_items(:one)
  end

  test "utility_group association exists" do
    utility_group = @utility_item.utility_group

    assert_instance_of UtilityGroup, utility_group
  end

  test "total attribute exists" do
    total = @utility_item.total

    assert_instance_of Integer, total
  end

  test "deffered attribute exists" do
    deffered = @utility_item.deffered

    assert_instance_of FalseClass, deffered
  end

  test "kind eum attribute allows valid values" do
    UtilityItem.kinds.keys.each do |kind|
      begin
        @utility_item.update_attribute! :kind, kind
      rescue ArgumentError
        flunk("#{kind} should be a valid value for the" +
          " 'kind' attribute and not raise an" +
          " ArgumentError")
      end
    end

    assert true
  end

  test "kind enum attribute disallows invalid option - rainbow" do
    rainbow = "rainbow"

    assert_raise ArgumentError do
      @utility_item.update_attribute! :kind, rainbow
    end
  end

  test "allows only unique kinds for each utility_group" do
    second_utility_item = utility_items(:two)
    utility_group = @utility_item.utility_group
    kind = @utility_item.kind

    assert_raise ActiveRecord::RecordNotUnique do
      second_utility_item.update! kind: kind, utility_group: utility_group
    end
  end
end
