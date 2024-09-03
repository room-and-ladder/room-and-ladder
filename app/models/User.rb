class User < ApplicationRecord
  belongs_to :user_group
  has_many :rentals, through: :user_group, dependent: :delete_all
  has_many :rent_exemptions # authorizer
  has_many :request_decisions # decider
end
