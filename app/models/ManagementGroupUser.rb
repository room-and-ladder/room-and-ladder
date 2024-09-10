# == Schema Information
#
# Table name: management_group_users
#
#  id                  :bigint           not null, primary key
#  active              :boolean          default(TRUE), not null
#  admin               :boolean          default(FALSE), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  management_group_id :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_management_group_users_on_management_group_id  (management_group_id)
#  index_management_group_users_on_user_id              (user_id)
#  management_group_users_single_admin_idx              (admin,management_group_id) UNIQUE WHERE (admin IS TRUE)
#
# Foreign Keys
#
#  fk_rails_...  (management_group_id => management_groups.id)
#  fk_rails_...  (user_id => users.id)
#
class ManagementGroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :management_group

  has_many :utility_exemptions
  has_many :rent_exemptions
  has_many :request_decisions
end
