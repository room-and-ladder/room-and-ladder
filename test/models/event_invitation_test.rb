# == Schema Information
#
# Table name: event_invitations
#
#  id                :bigint           not null, primary key
#  description       :text
#  invite_response   :enum             default("maybe"), not null
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  invitee_id        :bigint           not null
#  inviter_id        :bigint           not null
#  property_event_id :bigint           not null
#
# Indexes
#
#  index_event_invitations_on_invitee_id         (invitee_id)
#  index_event_invitations_on_inviter_id         (inviter_id)
#  index_event_invitations_on_property_event_id  (property_event_id)
#
# Foreign Keys
#
#  fk_rails_...  (invitee_id => users.id)
#  fk_rails_...  (inviter_id => users.id)
#  fk_rails_...  (property_event_id => property_events.id)
#
require "test_helper"

class EventInvitationTest < ActiveSupport::TestCase
  setup do
    @event_invitation = event_invitations(:one)
  end
  test "invitee association exists" do
    invitee = @event_invitation.invitee

    assert_instance_of User, invitee
  end
  test "inviter association exists" do
    inviter = @event_invitation.inviter

    assert_instance_of User, inviter
  end
  test "property_event association exists" do
    property_event = @event_invitation.property_event

    assert_instance_of PropertyEvent, property_event
  end
  test "title attribute exists" do
    title = @event_invitation.title

    assert_instance_of String, title
  end
  test "description association exists" do
    description = @event_invitation.description

    assert_instance_of String, description
  end
  test "invite_response eum attribute allows valid values" do
    EventInvitation.invite_responses.keys.each do |response|
      begin
        @event_invitation.update_attribute! :invite_response, response
      rescue ArgumentError
        flunk("#{response} should be a valid value for the" +
          " 'invite_response' attribute and not raise an" +
          " ArgumentError")
      end
    end

    assert true
  end
  test "invite_response enum attribute disallows invalid option - rainbow" do
    rainbow = "rainbow"

    assert_raise ArgumentError do
      @event_invitation.update_attribute! :invite_response, rainbow
    end
  end
end
