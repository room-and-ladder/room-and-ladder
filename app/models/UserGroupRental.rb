# == Schema Information
#
# Table name: user_group_rentals
#
#  id              :bigint           not null, primary key
#  active          :boolean          default(FALSE), not null
#  occupancy_range :daterange
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  rental_id       :bigint           not null
#  user_group_id   :bigint           not null
#
# Indexes
#
#  index_user_group_rentals_on_rental_id      (rental_id)
#  index_user_group_rentals_on_user_group_id  (user_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (rental_id => rentals.id)
#  fk_rails_...  (user_group_id => user_groups.id)
#
class UserGroupRental < ApplicationRecord
  belongs_to :rental
  belongs_to :user_group

  has_many :payment_transactions
  has_many :chores
  has_many :grievances
  has_many :property_events
  has_many :rent_exemptions
end
