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
require "test_helper"

class RequestDecisionTest < ActiveSupport::TestCase
  setup do
    @request_decision = request_decisions(:one)
  end
  test "request association exists" do
    request = @request_decision.request

    assert_instance_of Request, request
  end
  test "management_group_user association exists" do
    management_group_user = @request_decision.management_group_user

    assert_instance_of ManagementGroupUser, management_group_user
  end
  test "granted association exists" do
    granted = @request_decision.granted

    assert_instance_of FalseClass, granted
  end
  test "explanation association exists" do
    explanation = @request_decision.explanation

    assert_instance_of String, explanation
  end
end
