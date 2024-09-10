# == Schema Information
#
# Table name: user_groups
#
#  id                  :bigint           not null, primary key
#  name                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  management_group_id :bigint           not null
#
# Indexes
#
#  index_user_groups_on_management_group_id  (management_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (management_group_id => management_groups.id)
#
class UserGroup < ApplicationRecord
  belongs_to :management_group
  has_many :users
  has_many :user_group_rentals,  dependent: :delete_all
  has_many :rentals,  through: :user_group_rentals
end
