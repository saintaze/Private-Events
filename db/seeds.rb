# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


u = User.create!(name: "Micke", email: "b@b.com", password: "loobar", password_confirmation: "loobar")

u.events.create!(title: "Dancing", description: "Lets have a fun anicng lesson", location: "heorku", date: "2020-8-9")