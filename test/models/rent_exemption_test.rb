# == Schema Information
#
# Table name: rent_exemptions
#
#  id                       :bigint           not null, primary key
#  exemption_expiration     :datetime
#  exemption_percentage     :integer          default(100), not null
#  reason                   :text
#  redistribution_strategy  :enum             default("management"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  management_group_user_id :bigint           not null
#  user_group_rental_id     :bigint           not null
#
# Indexes
#
#  index_rent_exemptions_on_management_group_user_id  (management_group_user_id)
#  index_rent_exemptions_on_user_group_rental_id      (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (management_group_user_id => management_group_users.id)
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
require "test_helper"

class RentExemptionTest < ActiveSupport::TestCase
  setup do
    @rent_exemption = rent_exemptions(:one)
  end

  test "user_group_rental association exists" do
    user_group_rental = @rent_exemption.user_group_rental

    assert_instance_of UserGroupRental, user_group_rental
  end
  test "management_group_user association exists" do
    management_group_user = @rent_exemption.management_group_user

    assert_instance_of ManagementGroupUser, management_group_user
  end
  test "exemption_percentage attribute exists" do
    exemption_percentage = @rent_exemption.exemption_percentage

    assert_instance_of Integer, exemption_percentage
  end
  test "exemption_expiration attribute exists" do
    exemption_expiration = @rent_exemption.exemption_expiration

    assert_instance_of ActiveSupport::TimeWithZone, exemption_expiration
  end
  test "redistribution_strategy eum attribute allows valid values" do
    RentExemption.redistribution_strategies.keys.each do |strategy|
      begin
        @rent_exemption.update_attribute! :redistribution_strategy,
          strategy
      rescue ArgumentError
        flunk("#{strategy} should be a valid value for the" +
          " 'redistribution_strategy' attribute and not raise an" +
          " ArgumentError")
      end
    end

    assert true
  end

  test "kind enum attribute disallows invalid option - rainbow" do
    rainbow = "rainbow"

    assert_raise ArgumentError do
      @rent_exemption.update_attribute! :redistribution_strategy, rainbow
    end
  end

  test "reason attribute exists" do
    reason = @rent_exemption.reason

    assert_instance_of String, reason
  end
end
