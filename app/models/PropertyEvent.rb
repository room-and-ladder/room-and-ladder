class PropertyEvent < ApplicationRecord
  belongs_to :user_group_rental

  has_many :event_invitations
end
