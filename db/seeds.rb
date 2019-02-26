# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "creating 1 user (admin)..."
User.create(first_name: "Admin", last_name: "User", email: "admin@test.com", bio: "I'm Admin Regular, what else do you wanna know?", CPF: "4446667772", occupation: "Motherfucker CEO", address: "Eike's residence", phone_number: "11988776655", password: "123456", adm: true)
puts "done!"

puts "creating 1 good (car)..."
Good.create(brand: "Lamborgini", model: "Aventador", model_year: 2014, fabrication_year: 2015, chassis: "12345tfdsadfg", licens_plate: "EIK-1111", kilometers: "8000", price: "1500000", color: "perola", facts: "Esse carro eh foda!", version: "v12", good_type: 'car', photo_one: "photo1", photo_two: "photo2", photo_three: "photo3", photo_four: "photo4", video: "video")
puts "done!"
