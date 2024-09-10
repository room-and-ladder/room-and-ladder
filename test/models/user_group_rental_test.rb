# == Schema Information
#
# Table name: user_group_rentals
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(FALSE), not null
#  occupancy_range :daterange
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  rental_id       :bigint           not null
#  user_group_id   :bigint           not null
#
# Indexes
#
#  index_user_group_rentals_on_rental_id      (rental_id)
#  index_user_group_rentals_on_user_group_id  (user_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (rental_id => rentals.id)
#  fk_rails_...  (user_group_id => user_groups.id)
#
require "test_helper"

class UserGroupRentalTest < ActiveSupport::TestCase
  test "user_group association exists" do
    user_group = user_group_rentals(:one).user_group

    assert_instance_of UserGroup, user_group
  end
  test "many payment_transactions association exists" do
    payment_transaction = user_group_rentals(:one).payment_transactions.first

    assert_instance_of PaymentTransaction, payment_transaction
  end
  test "many chores association exists" do
    chore = user_group_rentals(:one).chores.first

    assert_instance_of Chore, chore
  end
  test "many grievances association exists" do
    grievance = user_group_rentals(:one).grievances.first

    assert_instance_of Grievance, grievance
  end
  test "many property_events association exists" do
    property_event = user_group_rentals(:one).property_events.first

    assert_instance_of PropertyEvent, property_event
  end
  test "many rent_exemptions association exists" do
    rent_exemption = user_group_rentals(:one).rent_exemptions.first

    assert_instance_of RentExemption, rent_exemption
  end
  test "occupancy_range attribute exists" do
    user_group_rental = user_group_rentals(:one)
    user_group_rental.update_attribute! :occupancy_range,
      Date.today..Date.tomorrow
    occupancy_range = user_group_rental.occupancy_range

    assert_instance_of Range, occupancy_range
  end

  test "active attribute exists" do
    active = user_group_rentals(:one).active

    assert_instance_of FalseClass, active
  end
end
