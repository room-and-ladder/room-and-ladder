# == Schema Information
#
# Table name: utility_groups
#
#  id            :bigint           not null, primary key
#  date          :datetime
#  property_wide :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  four_wall_id  :bigint           not null
#
# Indexes
#
#  index_utility_groups_on_four_wall_id  (four_wall_id)
#
# Foreign Keys
#
#  fk_rails_...  (four_wall_id => four_walls.id)
#
class UtilityGroup < ApplicationRecord
  belongs_to :four_wall

  has_many :utility_items
  has_many :utility_splits
end
