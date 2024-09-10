# == Schema Information
#
# Table name: requests
#
#  id                   :bigint           not null, primary key
#  appointment_date     :datetime
#  description          :text
#  duration             :interval
#  kind                 :enum             default("repair"), not null
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_group_rental_id :bigint           not null
#
# Indexes
#
#  index_requests_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
class Request < ApplicationRecord
  belongs_to :user_group_rental
  has_many :request_decisions

  # View "Model-Database Enum Sync" c-note before making
  # changes to this enum.
  enum :kind, { repair: "repair", reservation: "reservation", action:
                "action" }, prefix: true
end
