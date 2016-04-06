# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(first_name:"Alexey", last_name:"Levashev", email:"alex.levashev@gmail.com", password:"Mother1982", role:"Team # 1", admin:true)
User.create(first_name:"Sergey", last_name:"Ivanov", email:"sergey@ivanoff.com", password:"Sergey123", role:"Team # 1", admin:true)
User.create(first_name:"Vasyl", last_name:"Penar", email:"vasyl.penar@gmail.com", password:"Mother1982", role:"Team # 2", admin:false)
User.create(first_name:"Maksim", last_name:"Mychko", email:"maksim.mychko@gmail.com", password:"Mother1982", role:"Team # 1", admin:false)
User.create(first_name:"Slava", last_name:"Arikanov", email:"slava.arikanov@gmail.com", password:"Mother1982", role:"Team # 2", admin:true)
User.create(first_name:"Marek", last_name:"Valchar", email:"marek.valchar@gmail.com", password:"Mother1982", role:"Team # 1", admin:false)
