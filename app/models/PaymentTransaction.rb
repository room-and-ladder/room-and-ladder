class PaymentTransaction < ApplicationRecord
  belongs_to :user_group_rental


  statuses = { prompt: "prompt", early: "early", late: "late",
              overdue: "overdue", upcoming: "upcoming", waived: "waived" }

  enum :rent_payment_status, statuses, prefix: true
  enum :utilities_payment_status, statuses, prefix: true
end
