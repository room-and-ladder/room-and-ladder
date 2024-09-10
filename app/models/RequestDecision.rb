# == Schema Information
#
# Table name: request_decisions
#
#  id                       :bigint           not null, primary key
#  explanation              :text
#  granted                  :boolean
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  management_group_user_id :bigint           not null
#  request_id               :bigint           not null
#
# Indexes
#
#  index_request_decisions_on_management_group_user_id  (management_group_user_id)
#  index_request_decisions_on_request_id                (request_id)
#
# Foreign Keys
#
#  fk_rails_...  (management_group_user_id => management_group_users.id)
#  fk_rails_...  (request_id => requests.id)
#
class RequestDecision < ApplicationRecord
  belongs_to :request
  belongs_to :management_group_user
end
