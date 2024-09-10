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
class PropertyEvent < ApplicationRecord
  belongs_to :user_group_rental

  has_many :event_invitations

  # View "Model-Database Enum Sync" c-note before making
  # changes to this enum.
  enum :kind, { gas: "meeting", party: "party" }, prefix: true
end
