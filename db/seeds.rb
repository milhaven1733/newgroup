require 'faker'

User.destroy_all
Category.destroy_all
Ticket.destroy_all

music       = Category.create!(name: "Musicals",        desc: "music")
theater     = Category.create!(name: "Theater",         desc: "theater")
ballet      = Category.create!(name: "Ballet",          desc: "ballet")
dance       = Category.create!(name: "Dance",           desc: "dance")
opera       = Category.create!(name: "Opera",           desc: "opera")
orchestra   = Category.create!(name: "Orchestra",       desc: "orchestra")
museum      = Category.create!(name: "Museums",         desc: "museum")
comedy      = Category.create!(name: "Comedy",          desc: "comedy")
movie       = Category.create!(name: "Movie Theater",   desc: "movie")
zoo         = Category.create!(name: "Zoo/Aquarium",    desc: "zoo")
park        = Category.create!(name: "Amusement Parks", desc: "parks")
historic    = Category.create!(name: "Historic Sites",  desc: "historic sites")

User.create!(email: 'admin@test.com', password: 'password', role: 'admin', verification: true, name: "admin")
merchant = User.create!(email: "merchant@test.com", password: "password", role: "merchant", name: "merchant", verification: true)
user = User.create!(email: "normal@test.com", password: "password", role: "normal", name: 'user1')
student = User.create!(email: 'student@test.edu', password: 'password', role:'normal', name: 'student1')

merchant.create_merchant_info!(latitude: -34.397,
                                    longitude: 150.644, 
                                    url: Faker::Internet.url,
                                    workday_opening_time: '7:00 am - 10:00 pm',
                                    sat_opening_time: '9:00 am - 6:00 pm',
                                    sun_opening_time: '10:00 am - 10:30 pm',
                                    category_id: Category.first.id,
                                    orgnization: 'Merchant',
                                    phone: 1234567890,
                                    sales_phone: 1234567890,
                                    sales_email:'sales@email.com')
merchant.merchant_info.create_address(first: Faker::Address.street_address,
                                      second: Faker::Address.secondary_address,
                                      city: Faker::Address.city,
                                      state: Faker::Address.state,
                                      zipcode: Faker::Address.zip)

user.create_user_info!(phone:      Faker::PhoneNumber.phone_number,
                             group_name: Faker::Company.name,
                             )
user.user_info.create_address(first: Faker::Address.street_address,
                                      second: Faker::Address.secondary_address,
                                      city: Faker::Address.city,
                                      state: Faker::Address.state,
                                      zipcode: Faker::Address.zip)
student.create_user_info!(phone:      Faker::PhoneNumber.phone_number,
                             group_name: Faker::Company.name,
                             is_student: true)
student.user_info.create_address(first: Faker::Address.street_address,
                                      second: Faker::Address.secondary_address,
                                      city: Faker::Address.city,
                                      state: Faker::Address.state,
                                      zipcode: Faker::Address.zip)
user.wallet.update!(balance: 10000)
student.wallet.update!(balance: 10000)


#create tickets
images = ["http://media.ticketmaster.com/img/mw/images/a6/81/356598p1.jpg",
         "http://media.ticketmaster.com/img/mw/images/1c/be/363423p1.jpg",
         "http://media.ticketmaster.com/img/mw/images/e0/f1/341099p1.jpg"]
100.times.each do
  print '.'
  ticket = merchant.tickets.new
  ticket.name = Faker::Lorem.word
  ticket.desc = Faker::Lorem.sentence
  ticket.remote_image_url = images.sample
  ticket.category_id = Category.pluck(:id).sample
  ticket.start_at = Faker::Time.forward(23, :morning)
  ticket.end_at = ticket.start_at + 2.hours
  ticket.minimum_amount = Faker::Number.digit.to_i + 5
  ticket.shipping = 10
  ticket.city = ['New York', 'Philadelphia'].sample
  ticket.student_discount = 10
  ticket.oprice = Faker::Commerce.price
  ticket.will_call = true
  ticket.amount = 1000
  ticket.save!

  gp_1 = GroupPrice.create!(range_from:               5,
                            range_to:              20,
                            discount:              10)

  gp_2 = GroupPrice.create!(range_from:               21,
                            range_to:              50,
                            discount:              20)

  gp_3 = GroupPrice.create!(range_from:               51,
                            range_to:              1000,
                            discount:              30)
  ticket.group_prices << [gp_1, gp_2, gp_3]
end

