# == Schema Information
#
# Table name: property_resource_items
#
#  id                   :bigint           not null, primary key
#  available            :boolean
#  color                :string
#  current_quantity     :integer
#  expiration_date      :date
#  starting_quantity    :integer
#  total_cost           :integer
#  total_length         :integer
#  total_width          :integer
#  year                 :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  property_resource_id :bigint           not null
#
# Indexes
#
#  index_property_resource_items_on_property_resource_id  (property_resource_id)
#
# Foreign Keys
#
#  fk_rails_...  (property_resource_id => property_resources.id)
#
class PropertyResourceItem < ApplicationRecord
  belongs_to :property_resource
end
