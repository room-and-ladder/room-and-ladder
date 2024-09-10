# == Schema Information
#
# Table name: payment_transactions
#
#  id                              :bigint           not null, primary key
#  occupancy_duration              :interval
#  rent_amount                     :integer
#  rent_payment_due_date           :datetime
#  rent_payment_received_date      :datetime
#  rent_payment_status             :enum             default("upcoming"), not null
#  utilities_amount                :integer
#  utilities_included              :boolean          not null
#  utilities_payment_due_date      :datetime
#  utilities_payment_received_date :datetime
#  utilities_payment_status        :enum             default("upcoming"), not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  user_group_rental_id            :bigint           not null
#
# Indexes
#
#  index_payment_transactions_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
require "test_helper"

class PaymentTransactionTest < ActiveSupport::TestCase

  setup do
    @payment_transaction = payment_transactions(:one)
  end

  test "user_group_rental association exists" do
    user_group_rental = @payment_transaction.user_group_rental

    assert_instance_of UserGroupRental, user_group_rental
  end
  test "occupancy_duration attributes exists" do
    occupancy_duration = @payment_transaction.occupancy_duration

    assert_instance_of ActiveSupport::Duration, occupancy_duration
  end
  test "rent_payment_status eum attribute allows valid values" do
    PaymentTransaction.rent_payment_statuses.keys.each do |rent_payment_status|
      begin
        @payment_transaction.update_attribute! :rent_payment_status,
          rent_payment_status
      rescue ArgumentError
        flunk("#{rent_payment_status} should be a valid value for the 'rent_payment_status' attribute" + " and not raise an ArgumentError.")
      end
    end

    assert true
  end
  test "rent_payment_status enum attribute disallows
        invalid option - partner" do
    partner = "partner"

    assert_raise ArgumentError do
      @payment_transaction.update_attribute! :rent_payment_status, partner
    end
  end

  test "rent_payment_due_date attributes exists" do
    rent_payment_due_date = @payment_transaction.rent_payment_due_date

    assert_instance_of ActiveSupport::TimeWithZone, rent_payment_due_date
  end
  test "rent_payment_received_date attributes exists" do
    rent_payment_received_date = @payment_transaction
      .rent_payment_received_date

    assert_instance_of ActiveSupport::TimeWithZone, rent_payment_received_date
  end

  test "utilities_payment_due_date attributes exists" do
    utilities_payment_due_date = @payment_transaction
      .utilities_payment_due_date

    assert_instance_of ActiveSupport::TimeWithZone, utilities_payment_due_date
  end
  test "utilities_payment_received_date attributes exists" do
    utilities_payment_received_date = @payment_transaction
      .utilities_payment_received_date

    assert_instance_of ActiveSupport::TimeWithZone,
      utilities_payment_received_date
  end

  test "utilities_payment_status eum attribute allows valid values" do
    PaymentTransaction.utilities_payment_statuses.keys.each do |status|
      begin
        @payment_transaction.update_attribute! :utilities_payment_status,
          status
      rescue ArgumentError
        flunk("#{status} should be a valid value for the 'rent_payment_status' attribute" + " and not raise an ArgumentError.")
      end
    end

    assert true
  end
  test "utilities_payment_status enum attribute disallows
        invalid option - partner" do
    partner = "partner"

    assert_raise ArgumentError do
      @payment_transaction.update_attribute! :utilities_payment_status, partner
    end
  end
  test "rent_amount attributes exists" do
    rent_amount = @payment_transaction.rent_amount

    assert_instance_of Integer, rent_amount
  end
  test "utilities_amount attributes exists" do
    utilities_amount = @payment_transaction.utilities_amount

    assert_instance_of Integer, utilities_amount
  end
  test "utilities_included attributes exists" do
    utilities_included = @payment_transaction.utilities_included

    assert_instance_of FalseClass, utilities_included
  end
end
