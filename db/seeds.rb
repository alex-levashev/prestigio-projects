# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name:"Alexey", last_name:"Levashev", email:"alex.levashev@gmail.com", password:"Alexey123", role:"CZ", admin:true)
User.create(first_name:"Sergey", last_name:"Ivanov", email:"sergey@ivanoff.com", password:"Sergey123", role:"CZ", admin:true)
User.create(first_name:"Vasyl", last_name:"Penar", email:"vasyl.penar@gmail.com", password:"Vasyl123", role:"CN", admin:false)
User.create(first_name:"Maksim", last_name:"Mychko", email:"maksim.mychko@gmail.com", password:"Maksim123", role:"CN", admin:false)
User.create(first_name:"Slava", last_name:"Arikanov", email:"slava.arikanov@gmail.com", password:"Slava123", role:"CZ", admin:true)
User.create(first_name:"Marek", last_name:"Valchar", email:"marek.valchar@gmail.com", password:"Marek123", role:"CN", admin:false)
