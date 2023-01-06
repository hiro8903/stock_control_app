class Withdraw < ApplicationRecord
  belongs_to :user
  belongs_to :department
  belongs_to :paint
end
