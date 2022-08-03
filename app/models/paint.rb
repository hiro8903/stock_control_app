class Paint < ApplicationRecord
  belongs_to :manufacturer
  has_many :orders, foreign_key: "reference_id"
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
