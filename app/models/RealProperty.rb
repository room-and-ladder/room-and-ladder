# == Schema Information
#
# Table name: real_properties
#
#  id                  :bigint           not null, primary key
#  address             :string           not null
#  kind                :enum             not null
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  management_group_id :bigint           not null
#
# Indexes
#
#  index_real_properties_on_management_group_id  (management_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (management_group_id => management_groups.id)
#
class RealProperty < ApplicationRecord
  belongs_to :management_group

  has_many :four_walls
  has_many :rentals, dependent: :destroy, through: :four_walls

  # View "Model-Database Enum Sync" c-note before making
  # changes to this enum.
  enum :kind, { single_family: "single_family", condo: "condo", co_op: "co_op", townhome: "townhome", multi_family: "multi_family" }, prefix: true
end
