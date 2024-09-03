class RealProperty < ApplicationRecord
  belongs_to :management_group

  has_many :four_walls
  has_many :rentals, dependent: :destroy, through: :four_walls

  enum :kind, { single_family: "single_family", condo: "condo", co_op: "co_op", townhome: "townhome", multi_family: "multi_family" }, prefix: true
end
