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
class EventInvitation < ApplicationRecord
  belongs_to :property_event
  belongs_to :invitee, class_name: "User", foreign_key: "inviter_id"
  belongs_to :inviter, class_name: "User", foreign_key: "invitee_id"

  # View "Model-Database Enum Sync" c-note before making
  # changes to this enum.
  enum :invite_response, { no: "no", yes: "yes", maybe: "maybe",
    awaiting: "awaiting"
  }, prefix: true
end
