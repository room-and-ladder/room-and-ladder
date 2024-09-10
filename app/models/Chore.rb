# == Schema Information
#
# Table name: chores
#
#  id                   :bigint           not null, primary key
#  description          :text
#  frequency            :interval
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#
# Indexes
#
#  index_chores_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
class Chore < ApplicationRecord
  belongs_to :user_group_rental
end
