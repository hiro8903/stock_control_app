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

# メーカー作成
def create_manufacturer(name)
  Manufacturer.create!(name: name)
end

create_manufacturer("メーカーA")
create_manufacturer("メーカーB")
create_manufacturer("メーカーC")

# 仕入先作成
def create_supplier(name)
  Supplier.create!(name: name)
end

create_supplier("商社A")
create_supplier("商社B")
create_supplier("商社C")

# 塗料作成
def create_paint(name,
                manufacturer_id,
                unit_price,
                ordering_point,
                main_ingredient,
                warranty)
  Paint.create!(name: name,
              manufacturer_id: manufacturer_id,
              unit_price: unit_price,
              ordering_point: ordering_point,
              main_ingredient: main_ingredient,
              warranty: warranty)
end

create_paint("塗料A","1","1000","100","PTFE","30")
create_paint("塗料B","2","1500","50","PFA","365")
create_paint("塗料C","3","2000","150","ETFE","180")

