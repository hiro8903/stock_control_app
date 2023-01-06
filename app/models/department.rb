class Department < ApplicationRecord
  has_many :users
  has_many :inventorys
  has_many :withdraws, foreign_key: "reference_id"
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
