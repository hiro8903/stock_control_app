# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# coding: utf-8

# 部署作成
def create_department(name)
  Department.create!(name: name)
end

create_department("管理課")
create_department("A課")
create_department("B課")
create_department("C課")

User.create!(name: "Sample User",
            password: "pass",
            password_confirmation: "pass",
            department_id: 1)

User.create!(name: "User A",
            password: "pass",
            password_confirmation: "pass",
            department_id: 2)
User.create!(name: "User B",
            password: "pass",
            password_confirmation: "pass",
            department_id: 3)
User.create!(name: "User C",
              password: "pass",
              password_confirmation: "pass",
              department_id: 4)

60.times do |n|
  name  = Faker::Name.name
  password = "pass"
  User.create!(name: name,
              password: password,
              password_confirmation: password,
              department_id: "#{rand(1..3)}")
end

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

# 発注作成
def create_order(paint_id,
                user_id,
                order_on,
                quantity,
                desired_on,
                note,
                registerer_id,
                editor_id,
                unit_price,
                total_price)
  Order.create!(paint_id: paint_id,
                user_id: user_id,
                order_on: order_on,
                quantity: quantity,
                desired_on: desired_on,
                note: note,
                registerer_id: registerer_id,
                editor_id: editor_id,
                unit_price: unit_price,
                total_price: total_price)
end


  userA = User.find(2)
  userB = User.find(3)
  paintA = Paint.find(1)
  paintB = Paint.find(2)
  
  create_order(paintA.id, userA.id, Date.today, 50, Date.today.next_month, "びこう", userA.id, userA.id, paintA.unit_price, paintA.unit_price * 50)
  create_order(paintB.id, userB.id, Date.today, 100, Date.today.next_month, "びこう", userB.id, userB.id, paintB.unit_price, paintB.unit_price * 100)

# 各班の棚卸作成
def create_inventory(user_id,
                    editor_id,
                    department_id,
                    inventory_at,
                    paint_id,
                    quantity)
  Inventory.create!(user_id: user_id,
                    editor_id: editor_id,
                    department_id: department_id,
                    inventory_at: inventory_at,
                    paint_id: paint_id,
                    quantity: quantity)
                    
end

  create_inventory(userA.id,userA.id,userA.department_id,Date.current.beginning_of_month, paintA.id, 10)
  create_inventory(userA.id,userA.id,userA.department_id,Date.current.beginning_of_month, paintB.id, 20)
  create_inventory(userB.id,userB.id,userB.department_id,Date.current.beginning_of_month, paintA.id, 10)