class UtilityItem < ApplicationRecord
  belongs_to :utility_group

  enum :kind, { gas: "gas", electric: "electric", water: "water",
               internet: "internet", trash: "trash" }, prefix: true
end
