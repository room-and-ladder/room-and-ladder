# == Schema Information
#
# Table name: real_properties
#
#  id                  :bigint           not null, primary key
#  address             :string           not null
#  kind                :enum             not null
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  management_group_id :bigint           not null
#
# Indexes
#
#  index_real_properties_on_management_group_id  (management_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (management_group_id => management_groups.id)
#
require "test_helper"

class RealPropertyTest < ActiveSupport::TestCase
  test "management_group association exists" do
    management_group = real_properties(:one).management_group

    assert_instance_of ManagementGroup, management_group
  end
  test "many four_walls association exists" do
    management_group = real_properties(:one).management_group

    assert_instance_of ManagementGroup, management_group
  end
  test "many rentals association exists" do
    rental = real_properties(:one).rentals.first

    assert_instance_of Rental, rental
  end
  test "name attribute exists" do
    name = real_properties(:one).name

    assert_instance_of String, name
  end
  test "address attribute exists" do
    address = real_properties(:one).address

    assert_instance_of String, address
  end
  test "kind enum attribute allows single_family" do
    real_property = real_properties(:one)
    single_family = "single_family"

    real_property.update_attribute! :kind, RealProperty.kinds[single_family]

    assert_equal single_family, real_property.kind
  end

  test "kind enum attribute allows condo" do
    real_property = real_properties(:one)
    condo = "condo"

    real_property.update_attribute! :kind, RealProperty.kinds[condo]

    assert_equal condo, real_property.kind
  end
  test "kind enum attribute allows co_op" do
    real_property = real_properties(:one)
    co_op = "co_op"

    real_property.update_attribute! :kind, RealProperty.kinds[co_op]

    assert_equal co_op, real_property.kind
  end
  test "kind enum attribute allows townhome" do
    real_property = real_properties(:one)
    townhome = "townhome"

    real_property.update_attribute! :kind, RealProperty.kinds[townhome]

    assert_equal townhome, real_property.kind
  end
  test "kind enum attribute allows multi_family" do
    real_property = real_properties(:one)
    multi_family = "multi_family"

    real_property.update_attribute! :kind, RealProperty.kinds[multi_family]

    assert_equal multi_family, real_property.kind
  end
  test "kind enum attribute disallows invalid option - van" do
    real_property = real_properties(:one)
    van = "van"

    assert_raise ArgumentError do
      real_property.update_attribute! :kind, van
    end
  end
  test "kind enum attribute has five choices" do
    kind_of_real_properties_count = RealProperty.kinds.count

    assert_equal 5, kind_of_real_properties_count
  end
end
