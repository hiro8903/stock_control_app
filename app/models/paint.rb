class Paint < ApplicationRecord
  belongs_to :manufacturer
  has_many :orders, dependent: :destroy
  has_many :inventorys
  has_many :all_inbentories
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
