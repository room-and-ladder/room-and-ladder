# == Schema Information
#
# Table name: property_resources
#
#  id               :bigint           not null, primary key
#  available        :boolean          default(FALSE), not null
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  real_property_id :bigint           not null
#
# Indexes
#
#  index_property_resources_on_real_property_id  (real_property_id)
#
# Foreign Keys
#
#  fk_rails_...  (real_property_id => real_properties.id)
#
require "test_helper"

class PropertyResourceTest < ActiveSupport::TestCase
  setup do
    @property_resource = property_resources(:one)
  end
  test "available attribute exists" do
    available = @property_resource.available

    assert_instance_of FalseClass, available
  end
  test "name attribute exists" do
    name = @property_resource.name

    assert_instance_of String, name
  end

  test "real_property association exists" do
    real_property = @property_resource.real_property

    assert_instance_of RealProperty, real_property
  end

  test "many property_resources_items association exists" do
    property_resources_item = @property_resource.property_resource_items.first

    assert_instance_of PropertyResourceItem, property_resources_item
  end
end
