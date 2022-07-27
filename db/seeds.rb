# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# coding: utf-8

User.create!(name: "Sample User",
            password: "pass",
            password_confirmation: "pass")

60.times do |n|
  name  = Faker::Name.name
  password = "pass"
  User.create!(name: name,
              password: password,
              password_confirmation: password)
end

# 部署作成
def create_department(name)
  Department.create!(name: name)
end

create_department("営業部")
create_department("品質管理部")
create_department("生産管理課")
