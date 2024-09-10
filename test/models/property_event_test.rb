# == Schema Information
#
# Table name: property_events
#
#  id                   :bigint           not null, primary key
#  description          :text
#  event_date           :datetime
#  kind                 :enum             default("gas"), not null
#  location             :string
#  mandatory            :boolean          default(FALSE), not null
#  property_wide        :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#
# Indexes
#
#  index_property_events_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
require "test_helper"

class PropertyEventTest < ActiveSupport::TestCase
  setup do
    @property_event = property_events(:one)
  end

  test "user_group_rental association exists" do
    user_group_rental = @property_event.user_group_rental

    assert_instance_of UserGroupRental, user_group_rental
  end

  test "mandatory attribute exists" do
    mandatory = @property_event.mandatory

    assert_instance_of FalseClass, mandatory
  end
  test "property_wide attribute exists" do
    property_wide = @property_event.property_wide

    assert_instance_of FalseClass, property_wide
  end
  test "description attribute exists" do
    description = @property_event.description

    assert_instance_of String, description
  end
  test "event_date attribute exists" do
    event_date = @property_event.event_date

    assert_instance_of ActiveSupport::TimeWithZone, event_date
  end
  test "location attribute exists" do
    location = @property_event.location

    assert_instance_of String, location
  end

  test "kind eum attribute allows valid values" do
    PropertyEvent.kinds.keys.each do |kind|
      begin
        @property_event.update_attribute! :kind, kind
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
      @property_event.update_attribute! :kind, rainbow
    end
  end
end
