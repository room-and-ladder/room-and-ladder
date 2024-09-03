class UserGroupRental < ApplicationRecord
  belongs_to :rental
  belongs_to :user_group

  has_many :payment_transactions
  has_many :chores
  has_many :grievances
  has_many :property_events
  has_many :rent_exemptions
end
