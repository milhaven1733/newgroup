require 'ffaker'

User.destroy_all
Category.destroy_all
Ticket.destroy_all

merchant = User.create!(email: "merchant@test.com", password: "password", role: "merchant", name: "merchant")
User.create!(email: "normal@test.com", password: "password", role: "merchant")

art = Category.create!(name: "Art", desc: "art")
museum = Category.create!(name: "Museum", desc: "museum")
music = Category.create!(name: "Music", desc: "music")
opera = Category.create!(name: "Opera", desc: "opera")
theater = Category.create!(name: "Theater", desc: "theater")
sport = Category.create!(name: "Sport", desc: "sport")
zoo = Category.create!(name: "Zoo", desc: "zoo")

merchant.tickets.create!(name: "The black eyes", desc: "The Turn Blue World Tour starts September 5! See the Grammy Award winning duo perform in your city.", image_url: "http://media.ticketmaster.com/img/mw/images/a6/81/356598p1.jpg", amount: 12, category: music, start_at: DateTime.now, oprice_in_cents: 1200, city: "NewYork")
merchant.tickets.create!(name: "NFL ticket exchange", desc: " Buy & sell tickets the NFL-approved way.", image_url: "http://media.ticketmaster.com/img/mw/images/1c/be/363423p1.jpg", amount: 12, category: sport, start_at: DateTime.now, oprice_in_cents: 1200, city: "NewYork")
merchant.tickets.create!(name: "On Tour Now", desc: " You can still score great resale tickets for One Direction!", image_url: "http://media.ticketmaster.com/img/mw/images/e0/f1/341099p1.jpg", amount: 12, category: art, start_at: DateTime.now, oprice_in_cents: 1200, city: "NewYork")
merchant.tickets.create!(name: "The black eyes11", desc: "The Turn Blue World Tour starts September 5! See the Grammy Award winning duo perform in your city.", image_url: "http://media.ticketmaster.com/img/mw/images/a6/81/356598p1.jpg", amount: 12, category: music, start_at: DateTime.now, oprice_in_cents: 1200, city: "NewYork")
merchant.tickets.create!(name: "NFL ticket exchange11", desc: " Buy & sell tickets the NFL-approved way.", image_url: "http://media.ticketmaster.com/img/mw/images/1c/be/363423p1.jpg", amount: 12, category: sport, start_at: DateTime.now, oprice_in_cents: 1200, city: "NewYork")
merchant.tickets.create!(name: "On Tour Now11", desc: " You can still score great resale tickets for One Direction!", image_url: "http://media.ticketmaster.com/img/mw/images/e0/f1/341099p1.jpg", amount: 12, category: art, start_at: DateTime.now, oprice_in_cents: 1200, city: "NewYork")

merchant.merchant_infos.create!(user_id: 1,
  latitude: -34.397,
  longitude: 150.644, 
  url: 'http://google.com',
  workday_opening_time: '7:00 am - 10:00 pm',
  sat_opening_time: '9:00 am - 6:00 pm',
  sun_opening_time: '10:00 am - 10:30 pm')