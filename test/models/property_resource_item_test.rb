# == Schema Information
#
# Table name: property_resource_items
#
#  id                   :bigint           not null, primary key
#  available            :boolean
#  color                :string
#  current_quantity     :integer
#  expiration_date      :date
#  starting_quantity    :integer
#  total_cost           :integer
#  total_length         :integer
#  total_width          :integer
#  year                 :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  property_resource_id :bigint           not null
#
# Indexes
#
#  index_property_resource_items_on_property_resource_id  (property_resource_id)
#
# Foreign Keys
#
#  fk_rails_...  (property_resource_id => property_resources.id)
#
require "test_helper"

class PropertyResourceItemTest < ActiveSupport::TestCase
  setup do
    @property_resource_item = property_resource_items(:one)
  end
  test "property_resource association exists" do
    property_resource = @property_resource_item.property_resource

    assert_instance_of PropertyResource, property_resource
  end

  test "starting_quantity attribute exists" do
    starting_quantity = @property_resource_item.starting_quantity

    assert_instance_of Integer, starting_quantity
  end
  test "current_quantity attribute exists" do
    current_quantity = @property_resource_item.current_quantity

    assert_instance_of Integer, current_quantity
  end
  test "total_cost attribute exists" do
    total_cost = @property_resource_item.total_cost

    assert_instance_of Integer, total_cost
  end
  test "total_length attribute exists" do
    total_length = @property_resource_item.total_length

    assert_instance_of Integer, total_length
  end
  test "total_width attribute exists" do
    total_width = @property_resource_item.total_width

    assert_instance_of Integer, total_width
  end
  test "year attribute exists" do
    year = @property_resource_item.year

    assert_instance_of ActiveSupport::TimeWithZone, year
  end
  test "expiration_date attribute exists" do
    expiration_date = @property_resource_item.expiration_date

    assert_instance_of Date, expiration_date
  end
  test "color attribute exists" do
    color = @property_resource_item.color

    assert_instance_of String, color
  end
  test "available attribute exists" do
    available = @property_resource_item.available

    assert_instance_of FalseClass, available
  end
end
