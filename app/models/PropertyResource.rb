class PropertyResource < ApplicationRecord
  belongs_to :real_property
  belongs_to :user

  has_many :event_invitations
end
