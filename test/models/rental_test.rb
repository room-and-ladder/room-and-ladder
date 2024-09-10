# == Schema Information
#
# Table name: rentals
#
#  id                         :bigint           not null, primary key
#  address                    :string           not null
#  available                  :boolean          default(FALSE), not null
#  kind                       :enum             not null
#  name                       :string           not null
#  parking_assignment         :string
#  primary_door_access_code   :string
#  rent_rate                  :integer          default(0), not null
#  secondary_door_access_code :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  four_wall_id               :bigint           not null
#
# Indexes
#
#  index_rentals_on_four_wall_id  (four_wall_id)
#
# Foreign Keys
#
#  fk_rails_...  (four_wall_id => four_walls.id)
#
require "test_helper"

class RentalTest < ActiveSupport::TestCase
  test "rent_rate attribute exists" do
    rent_rate = rentals(:one).rent_rate

    assert_instance_of Integer, rent_rate
  end
  test "available attribute exists" do
    available = rentals(:one).available

    assert_instance_of FalseClass, available
  end
  test "address attribute exists" do
    address = rentals(:one).address

    assert_instance_of String, address
  end
  test "parking_assignment attribute exists" do
    parking_assignment = rentals(:one).parking_assignment

    assert_instance_of String, parking_assignment
  end
  test "primary_door_access_code attribute exists" do
    primary_door_access_code = rentals(:one).primary_door_access_code

    assert_instance_of String, primary_door_access_code
  end
  test "secondary_door_access_code attribute exists" do
    secondary_door_access_code = rentals(:one).secondary_door_access_code

    assert_instance_of String, secondary_door_access_code
  end
  test "name attribute exists" do
    name = rentals(:one).name

    assert_instance_of String, name
  end

  test "kind enum attribute disallows invalid option - partner" do
    rental = rentals(:one)
    partner = "partner"

    assert_raise ArgumentError do
      rental.update_attribute! :kind, partner
    end
  end

  test "kind eum attribute allows valid values" do
    rental = rentals(:one)

    Rental.kinds.keys.each do |rental_kind|
      begin
        rental.update_attribute! :kind, rental_kind
      rescue ArgumentError
        flunk("#{rental_kind} should be a valid value for the 'kind' attribute" + " and not raise an ArgumentError.")
      end
    end

    assert true
  end
end
