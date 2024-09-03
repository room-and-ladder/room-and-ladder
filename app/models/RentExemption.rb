class RentExemption < ApplicationRecord
  belongs_to :user_group_rental
  belongs_to :user

  enum :redistribution_strategy, {
    management: "management", roommates: "roommates"
  }, prefix: true
end
