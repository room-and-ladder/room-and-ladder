# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  display_name  :string
#  email         :string           not null
#  kind          :enum             default("tenant"), not null
#  name          :string           not null
#  phone_number  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_group_id :bigint           not null
#
# Indexes
#
#  index_users_on_user_group_id  (user_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_id => user_groups.id)
#
class User < ApplicationRecord
  belongs_to :user_group
  has_many :rentals, through: :user_group, dependent: :delete_all

  # View "Model-Database Enum Sync" c-note before making
  # changes to this enum.
  enum :kind,
  { tenant: "tenant", manager: "manager", owner: "owner" }, prefix: true
end
