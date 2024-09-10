# == Schema Information
#
# Table name: payment_transactions
#
#  id                              :bigint           not null, primary key
#  occupancy_duration              :interval
#  rent_amount                     :integer
#  rent_payment_due_date           :datetime
#  rent_payment_received_date      :datetime
#  rent_payment_status             :enum             default("upcoming"), not null
#  utilities_amount                :integer
#  utilities_included              :boolean          not null
#  utilities_payment_due_date      :datetime
#  utilities_payment_received_date :datetime
#  utilities_payment_status        :enum             default("upcoming"), not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  user_group_rental_id            :bigint           not null
#
# Indexes
#
#  index_payment_transactions_on_user_group_rental_id  (user_group_rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_group_rental_id => user_group_rentals.id)
#
class PaymentTransaction < ApplicationRecord
  belongs_to :user_group_rental


  statuses = { prompt: "prompt", early: "early", late: "late",
              overdue: "overdue", upcoming: "upcoming", waived: "waived" }

  # View "Model-Database Enum Sync" c-note before making
  # changes to these enums.
  enum :rent_payment_status, statuses, prefix: true
  enum :utilities_payment_status, statuses, prefix: true
end
