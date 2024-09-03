class Rental < ApplicationRecord
  belongs_to :four_wall

  has_many :user_group_rentals

  has_many :payment_transactions, through: :user_group_rentals
end
