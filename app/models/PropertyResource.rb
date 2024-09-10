# == Schema Information
#
# Table name: property_resources
#
#  id               :bigint           not null, primary key
#  available        :boolean          default(FALSE), not null
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  real_property_id :bigint           not null
#
# Indexes
#
#  index_property_resources_on_real_property_id  (real_property_id)
#
# Foreign Keys
#
#  fk_rails_...  (real_property_id => real_properties.id)
#
class PropertyResource < ApplicationRecord
  belongs_to :real_property

  has_many :property_resource_items
end
