# == Schema Information
#
# Table name: requests
#
#  id                   :bigint           not null, primary key
#  appointment_date     :datetime
#  description          :text
#  duration             :interval
#  kind                 :enum             default("repair"), not null
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#
# Indexes
#
#  index_requests_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
require "test_helper"

class RequestTest < ActiveSupport::TestCase
  setup do
    @request = requests(:one)
  end
  test "user_group_rental association exists" do
    user_group_rental = @request.user_group_rental

    assert_instance_of UserGroupRental, user_group_rental
  end
  test "many request_decisions association exists" do
    request_decision = @request.request_decisions.first

    assert_instance_of RequestDecision, request_decision
  end
  test "title attribute exists" do
    title = @request.title

    assert_instance_of String, title
  end
  test "description attribute exists" do
    description = @request.description

    assert_instance_of String, description
  end
  test "appointment_date attribute exists" do
    appointment_date = @request.appointment_date

    assert_instance_of ActiveSupport::TimeWithZone, appointment_date
  end
  test "duration attribute exists" do
    @request.update_attribute! :duration, 5.days

    assert_instance_of ActiveSupport::Duration, @request.duration
  end
  test "kind eum attribute allows valid values" do
    Request.kinds.keys.each do |kind|
      begin
        @request.update_attribute! :kind, kind
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
      @request.update_attribute! :kind, rainbow
    end
  end
end
