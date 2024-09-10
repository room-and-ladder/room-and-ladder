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
require "test_helper"

class ManagementGroupUserTest < ActiveSupport::TestCase
  test "admin attribute exists" do
    admin = management_group_users(:one).admin

    assert_instance_of FalseClass, admin
  end

  test "active attribute exists" do
    active = management_group_users(:one).active

    assert_instance_of TrueClass, active
  end
  test "user association exists" do
    user = management_group_users(:one).user

    assert_instance_of User, user
  end
  test "management_group association exists" do
    management_group = management_group_users(:one).management_group

    assert_instance_of ManagementGroup, management_group
  end
  test "many utility_exemptions association exists" do
    utility_exemption = management_group_users(:one).utility_exemptions.first

    assert_instance_of UtilityExemption, utility_exemption
  end
  test "many rent_exemptions association exists" do
    rent_exemption = management_group_users(:one).rent_exemptions.first

    assert_instance_of RentExemption, rent_exemption
  end
  test "many request_decisions association exists" do
    request_decision = management_group_users(:one).request_decisions.first

    assert_instance_of RequestDecision, request_decision
  end

  test "allows up to a single admin per management_group_user" do
    management_group_user_one = management_group_users(:one)
    management_group_user_two = management_group_users(:two)
    management_group_one = management_groups(:one)
    management_group_two = management_groups(:two)

    management_group_user_one.update!(
      management_group: management_group_one,
      admin: true)

    assert_raise ActiveRecord::RecordNotUnique do
      management_group_user_two.update!(
        management_group: management_group_one,
        admin: true)
    end

    begin
      management_group_user_two.update!(
        management_group: management_group_one,
        admin: false)
    rescue ActiveRecord::RecordNotUnique
      flunk("Expected no error with the same management group and admin set to
        false")
    end

    begin
      management_group_user_two.update!(
        management_group: management_group_two,
        admin: true)
    rescue ActiveRecord::RecordNotUnique
      flunk("Expected no error with different management group and admin set to
        true")
    end
  end
end
