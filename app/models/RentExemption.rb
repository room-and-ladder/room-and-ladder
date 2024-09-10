# == Schema Information
#
# Table name: rent_exemptions
#
#  id                       :bigint           not null, primary key
#  exemption_expiration     :datetime
#  exemption_percentage     :integer          default(100), not null
#  reason                   :text
#  redistribution_strategy  :enum             default("management"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  management_group_user_id :bigint           not null
#  user_group_rental_id     :bigint           not null
#
# Indexes
#
#  index_rent_exemptions_on_management_group_user_id  (management_group_user_id)
#  index_rent_exemptions_on_user_group_rental_id      (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (management_group_user_id => management_group_users.id)
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
class RentExemption < ApplicationRecord
  belongs_to :user_group_rental
  belongs_to :management_group_user

  # View "Model-Database Enum Sync" c-note before making
  # changes to this enum.
  enum :redistribution_strategy, {
    management: "management", roommates: "roommates"
  }, prefix: true
end
