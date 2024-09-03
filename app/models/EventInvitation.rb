class EventInvitation < ApplicationRecord
  belongs_to :property_event
  belongs_to :invitee, class_name: "User", foreign_key: "inviter_id"
  belongs_to :inviter, class_name: "User", foreign_key: "invitee_id"

  enum :invite_response, { no: "no", yes: "yes", maybe: "maybe",
    awaiting: "awaiting"
  }, prefix: true
end
