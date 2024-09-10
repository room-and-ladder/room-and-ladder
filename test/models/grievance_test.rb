# == Schema Information
#
# Table name: grievances
#
#  id                   :bigint           not null, primary key
#  anonymous            :boolean          default(TRUE), not null
#  description          :text
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#
# Indexes
#
#  index_grievances_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
require "test_helper"

class GrievanceTest < ActiveSupport::TestCase
  setup do
    @grievance = grievances(:one)
  end
  test "user_group_rental association exists" do
    user_group_rental = @grievance.user_group_rental

    assert_instance_of UserGroupRental, user_group_rental
  end
  test "title attribute exists" do
    title = @grievance.title

    assert_instance_of String, title
  end
  test "anonymous attribute exists" do
    anonymous = @grievance.anonymous

    assert_instance_of FalseClass, anonymous
  end
  test "description attribute exists" do
    description = @grievance.description

    assert_instance_of String, description
  end
end
