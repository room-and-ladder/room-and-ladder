# == Schema Information
#
# Table name: utility_items
#
#  id               :bigint           not null, primary key
#  deffered         :boolean          default(FALSE), not null
#  kind             :enum             not null
#  total            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  utility_group_id :bigint           not null
#
# Indexes
#
#  index_utility_items_on_kind_and_utility_group_id  (kind,utility_group_id) UNIQUE
#  index_utility_items_on_utility_group_id           (utility_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (utility_group_id => utility_groups.id)
#
class UtilityItem < ApplicationRecord
  belongs_to :utility_group

  # View "Model-Database Enum Sync" c-note before making
  # changes to this enum.
  enum :kind, { gas: "gas", electric: "electric", water: "water",
               internet: "internet", trash: "trash" }, prefix: true
end
