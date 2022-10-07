class Department < ApplicationRecord
  has_many :users
  has_many :inventorys
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
