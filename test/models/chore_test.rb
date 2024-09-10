# == Schema Information
#
# Table name: chores
#
#  id                   :bigint           not null, primary key
#  description          :text
#  frequency            :interval
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#
# Indexes
#
#  index_chores_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
require "test_helper"

class ChoreTest < ActiveSupport::TestCase
  setup do
    @chore = chores(:one)
  end
  test "user_group_rental association exists" do
    user_group_rental = @chore.user_group_rental

    assert_instance_of UserGroupRental, user_group_rental
  end
  test "title attribute exists" do
    title = @chore.title

    assert_instance_of String, title
  end
  test "description attribute exists" do
    description = @chore.description

    assert_instance_of String, description
  end
  test "frequency attribute exists" do
    @chore.update_attribute :frequency, 1.days

    assert_instance_of ActiveSupport::Duration, @chore.frequency
  end
end
