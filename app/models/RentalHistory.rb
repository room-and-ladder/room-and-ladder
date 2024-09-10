# == Schema Information
#
# Table name: rental_histories
#
#  id                   :bigint           not null, primary key
#  available            :boolean
#  date_of_change       :datetime
#  parking_assignment   :string
#  rent_rate            :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#
# Indexes
#
#  index_rental_histories_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
class RentalHistory < ApplicationRecord
  belongs_to :user_group_rental
end
