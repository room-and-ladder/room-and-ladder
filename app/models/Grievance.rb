# == Schema Information
#
# Table name: grievances
#
#  id                   :bigint           not null, primary key
#  anonymous            :boolean          default(TRUE), not null
#  description          :text
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#
# Indexes
#
#  index_grievances_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
class Grievance < ApplicationRecord
  belongs_to :user_group_rental
end
