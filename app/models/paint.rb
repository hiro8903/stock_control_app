class Paint < ApplicationRecord
  belongs_to :manufacturer
  has_many :orders, dependent: :destroy
  has_many :inventories
  has_many :all_inventories
  has_many :withdraws, foreign_key: "reference_id"
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
