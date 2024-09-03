class ManagementGroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :management_group
end
