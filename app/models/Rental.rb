# == Schema Information
#
# Table name: rentals
#
#  id                         :bigint           not null, primary key
#  address                    :string           not null
#  available                  :boolean          default(FALSE), not null
#  kind                       :enum             not null
#  name                       :string           not null
#  parking_assignment         :string
#  primary_door_access_code   :string
#  rent_rate                  :integer          default(0), not null
#  secondary_door_access_code :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  four_wall_id               :bigint           not null
#
# Indexes
#
#  index_rentals_on_four_wall_id  (four_wall_id)
#
# Foreign Keys
#
#  fk_rails_...  (four_wall_id => four_walls.id)
#
class Rental < ApplicationRecord
  belongs_to :four_wall

  has_many :user_group_rentals

  has_many :payment_transactions, through: :user_group_rentals

  # View "Model-Database Enum Sync" c-note before making
  # changes to this enum.
  enum :kind,
  { apartment: "apartment", bedroom: "bedroom", condo: "condo", house: "house", townhome: "townhome", multi_family: "multi_family" }, prefix: true
end
