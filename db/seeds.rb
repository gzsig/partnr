# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def seed_image(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}.jpg"))
end

def seed_video(file_name)
  File.open(File.join(Rails.root, "/app/assets/images/seed/#{file_name}.mp4"))
end

puts "creating 5 users (1st is admin)..."
  User.create(first_name: "Diego", last_name: "Gonzales", email: "diegogonzalesdesouza@gmail.com", bio: "I'm Admin Regular, what else do you wanna know?", CPF: "44466492808", occupation: "Motherfucker CEO", address: "Eike's residence", phone_number: "11988775551", password: "123123", favorite: "Carro", adm: true)
  User.create(first_name: "Gabriel", last_name: "Zsigmond", email: "gaazsig@gmail.com", bio: "I'm Regular, what else do you wanna know?", CPF: "47688683807", occupation: "Motherfucker CEO", address: "Eike's residence", phone_number: "11933021103", password: "123123", favorite: "Barco", adm: true)
  User.create(first_name: "Fabi", last_name: "Carvalho", email: "fabiii.fa@gmail.com", bio: "I'm Regular, what else do you wanna know?", CPF: "41931115800", occupation: "Motherfucker CEO", address: "Eike's residence", phone_number: "11995845237", password: "123123", favorite: "Helicoptero", adm: true)
puts "done!"

  puts "creating 1 (car)..."
  Good.create(brand: ["Lamborgini"].sample, model: "Aventador", model_year: 2014, fabrication_year: [2018].sample, body_style: ['sport'].sample, serial_number: "76FGBS3N29W", licens_plate: "EIK-1111", kilometers: "900", price: ["4700000"].sample, color: ["branco"].sample, facts: "MSRP: From CR$4.7 million \n Max speed: 350 km/h \n Horsepower: 700 to 740 hp \n Dimensions: 4,780-4,797 mm L x 2,030 mm W x 1,136 mm H \n Acceleration 0-100 km/h: 2.9 to 3 seconds \n Fuel tank capacity: 85 to 90 L", version: "v12", good_type: ['Carro'].sample, photo_one: seed_image('carousel1'), photo_two: seed_image('carousel2'), photo_three: seed_image('carousel3'), photo_four: seed_image('carousel4'))

puts "done!"
