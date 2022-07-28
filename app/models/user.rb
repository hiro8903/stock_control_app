class User < ApplicationRecord
  belongs_to :department, foreign_key: "department_id", optional: true
  validates :name, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true
end
