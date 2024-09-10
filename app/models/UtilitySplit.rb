# == Schema Information
#
# Table name: utility_splits
#
#  id                   :bigint           not null, primary key
#  occupancy_duration   :interval
#  split_charge         :integer
#  split_points         :integer
#  split_rate           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#  utility_group_id     :bigint           not null
#
# Indexes
#
#  index_utility_splits_on_user_group_rental_id  (user_group_rental_id)
#  index_utility_splits_on_utility_group_id      (utility_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#  fk_rails_...  (utility_group_id => utility_groups.id)
#
class UtilitySplit < ApplicationRecord
  belongs_to :utility_group
  belongs_to :user_group_rental
end
