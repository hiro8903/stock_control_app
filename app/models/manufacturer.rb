class Manufacturer < ApplicationRecord
  has_many :paints, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
