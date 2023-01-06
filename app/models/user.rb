class User < ApplicationRecord
  belongs_to :department, foreign_key: "department_id", optional: true
  has_many :orders, foreign_key: "reference_id"
  has_many :orders, foreign_key: "registerer_id"
  has_many :orders, foreign_key: "editor_id"
  has_many :arrivals, foreign_key: "arrival_id"
  has_many :inventorys, foreign_key: "reference_id"
  has_many :inventorys, foreign_key: "editor_id"
  has_many :withdraws, foreign_key: "reference_id"
  with_options presence: true do
    validates :name
    validates :department_id
  end
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true
end
