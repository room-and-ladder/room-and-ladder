# == Schema Information
#
# Table name: rental_histories
#
#  id                   :bigint           not null, primary key
#  available            :boolean
#  date_of_change       :datetime
#  parking_assignment   :string
#  rent_rate            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#
# Indexes
#
#  index_rental_histories_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
require "test_helper"

class RentalHistoryTest < ActiveSupport::TestCase
  setup do
    @rental_history = rental_histories(:one)
  end
  test "user_group_rental association exists" do
    user_group_rental = @rental_history.user_group_rental

    assert_instance_of UserGroupRental, user_group_rental
  end
  test "rent_rate attribute exists" do
    rent_rate = @rental_history.rent_rate

    assert_instance_of Integer, rent_rate
  end
  test "parking_assignment attribute exists" do
    parking_assignment = @rental_history.parking_assignment

    assert_instance_of String, parking_assignment
  end
  test "available attribute exists" do
    available = @rental_history.available

    assert_instance_of FalseClass, available
  end
  test "date_of_change attribute exists" do
    date_of_change = @rental_history.date_of_change

    assert_instance_of ActiveSupport::TimeWithZone, date_of_change
  end
end
