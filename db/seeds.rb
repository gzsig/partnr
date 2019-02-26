# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "creating 1 user..."

User.create(first_name: "Eike", last_name: "Batista", email: "im@eike.com", bio: "I'm Eike, what else do you wanna know?", CPF: "4446667772", occupation: "Motherfucker CEO", address: "Eike's residence", phone_number: "11988776655", password: "123456", adm: true)

puts "done!"

