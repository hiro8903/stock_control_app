class Paint < ApplicationRecord
  belongs_to :manufacturer
  has_many :orders, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
end
