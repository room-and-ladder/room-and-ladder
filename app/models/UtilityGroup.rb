class UtilityGroup < ApplicationRecord
  belongs_to :four_wall

  has_many :utility_items
  has_many :utility_splits
end
