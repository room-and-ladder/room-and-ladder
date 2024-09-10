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
require "test_helper"
class UserTest < ActiveSupport::TestCase
  test "rental association exists" do
    rental = users(:one).rentals.first

    assert_instance_of Rental, rental
  end

  test "user_group association exists" do
    user_group = users(:one).user_group

    assert_instance_of UserGroup, user_group
  end

  test "display_name attribute exists" do
    display_name = users(:one).display_name

    assert_instance_of String, display_name
  end

  test "name attribute exists" do
    name = users(:one).name

    assert_instance_of String, name
  end

  test "phone_number attribute exists" do
    phone_number = users(:one).phone_number

    assert_instance_of String, phone_number
  end

  test "email attribute exists" do
    email = users(:one).email

    assert_instance_of String, email
  end
  test "kind enum attribute allows tenant" do
    user = users(:one)
    tenant = "tenant"

    user.update_attribute! :kind, User.kinds[tenant]

    assert_equal tenant, user.kind
  end

  test "kind enum attribute allows manager" do
    user = users(:one)
    manager = "manager"

    user.update_attribute! :kind, User.kinds[manager]

    assert_equal manager, user.kind
  end
  test "kind enum attribute allows owner" do
    user = users(:one)
    owner = "owner"

    user.update_attribute! :kind, User.kinds[owner]

    assert_equal owner, user.kind
  end

  test "kind enum attribute disallows invalid option - partner" do
    user = users(:one)
    partner = "partner"

    assert_raise ArgumentError do
      user.update_attribute! :kind, partner
    end
  end


  test "kind enum attribute has three choices" do
    kind_of_users_count = User.kinds.count

    assert_equal 3, kind_of_users_count
  end
end
