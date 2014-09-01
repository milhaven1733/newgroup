require 'ffaker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Category.destroy_all
Ticket.destroy_all

merchant = User.create!(email: "merchant@test.com", password: "password", role: "merchant")
User.create!(email: "normal@test.com", password: "password", role: "merchant")

music = Category.create!(name: "music", desc: "music")
sport = Category.create!(name: "sport", desc: "sport")
art = Category.create!(name: "art", desc: "art")


merchant.tickets.create!(name: "The black eyes", desc: "The Turn Blue World Tour starts September 5! See the Grammy Award winning duo perform in your city.", image_url: "http://media.ticketmaster.com/img/mw/images/a6/81/356598p1.jpg", amount: 12, category: music, start_at: DateTime.now - 10.hours, end_at: DateTime.now, oprice_in_cents: 1200)
merchant.tickets.create!(name: "NFL ticket exchange", desc: " Buy & sell tickets the NFL-approved way.", image_url: "http://media.ticketmaster.com/img/mw/images/1c/be/363423p1.jpg", amount: 12, category: sport, start_at: DateTime.now - 10.hours, end_at: DateTime.now, oprice_in_cents: 1200)
merchant.tickets.create!(name: "On Tour Now", desc: " You can still score great resale tickets for One Direction!", image_url: "http://media.ticketmaster.com/img/mw/images/e0/f1/341099p1.jpg", amount: 12, category: art, start_at: DateTime.now - 10.hours, end_at: DateTime.now, oprice_in_cents: 1200)
