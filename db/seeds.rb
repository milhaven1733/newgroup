require 'faker'

User.destroy_all
Category.destroy_all
Ticket.destroy_all

merchant = User.create!(email: "merchant@test.com", password: "password", role: "merchant", name: "merchant")
User.create!(email: "normal@test.com", password: "password", role: "normal")

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

gp_1 = GroupPrice.create!(range_from:               5,
                             range_to:              20,
                             discount:              10)

gp_2 = GroupPrice.create!(range_from:               21,
                             range_to:              50,
                             discount:              20)

gp_3 = GroupPrice.create!(range_from:               51,
                             range_to:              100,
                             discount:              30)


ticket1 = merchant.tickets.create!(name:             "The black eyes",
                                  desc:             " The Turn Blue World Tour starts September 5! See the Grammy Award winning duo perform in your city.", 
                                  remote_image_url: "http://media.ticketmaster.com/img/mw/images/a6/81/356598p1.jpg",
                                  amount:           120, 
                                  category:         music, 
                                  start_at:         DateTime.now, 
                                  end_at:           (DateTime.now + 2.hours),
                                  minimum_amount:   5,
                                  shipping:         5,
                                  city:             "NewYork",
                                  student_discount: 10,
                                  oprice:           100)
ticket1.group_prices << [gp_1, gp_2, gp_3]

ticket2 = merchant.tickets.create!(name:            "NFL ticket exchange",
                         desc:                      " Buy & sell tickets the NFL-approved way.",
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/1c/be/363423p1.jpg",
                         amount:                    120,
                         category:                  orchestra,
                         start_at:                  DateTime.now,
                         end_at:                    (DateTime.now + 2.hours),
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    80,
                         student_discount: 10,
                         city:                      "NewYork")
ticket2.group_prices << [gp_1, gp_2, gp_3]

ticket3 = merchant.tickets.create!(name:            "On Tour Now",
                         desc:                      " You can still score great resale tickets for One Direction!", 
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/e0/f1/341099p1.jpg", 
                         amount:                    1200,
                         category:                  ballet,
                         start_at:                  DateTime.now,
                         end_at:                    (DateTime.now + 2.hours),
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    90,
                         student_discount: 10,
                         city:                      "NewYork")
ticket3.group_prices << [gp_1, gp_2, gp_3]

ticket4 = merchant.tickets.create!(name:                      "The black eyes11", 
                         desc:                      "The Turn Blue World Tour starts September 5! See the Grammy Award winning duo perform in your city.", 
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/a6/81/356598p1.jpg", 
                         amount:                    120, 
                         category:                  music, 
                         start_at:                  DateTime.now, 
                         end_at:                    (DateTime.now + 2.hours), 
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    50,
                         student_discount: 10,
                         city:                      "NewYork")
ticket4.group_prices << [gp_1, gp_2, gp_3]

                        
ticket5 = merchant.tickets.create!(name:                      "NFL ticket exchange11",
                         desc:                      " Buy & sell tickets the NFL-approved way.",
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/1c/be/363423p1.jpg",
                         amount:                    120,
                         category:                  orchestra,
                         start_at:                  DateTime.now,
                         end_at:                    (DateTime.now + 2.hours),
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    100,
                         student_discount: 10,
                         city:                      "NewYork")
ticket5.group_prices << [gp_1, gp_2, gp_3]

ticket6 = merchant.tickets.create!(name:                      "On Tour Now11",
                         desc:                      " You can still score great resale tickets for One Direction!",
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/e0/f1/341099p1.jpg",
                         amount:                    120,
                         category:                  dance,
                         start_at:                  DateTime.now,
                         end_at:                    (DateTime.now + 2.hours),
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    100,
                         student_discount: 10,
                         city:                      "NewYork")
ticket6.group_prices << [gp_1, gp_2, gp_3]


ticket7 = merchant.tickets.create!(name:            "NFL ticket exchange",
                         desc:                      " Buy & sell tickets the NFL-approved way.",
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/1c/be/363423p1.jpg",
                         amount:                    120,
                         category:                  orchestra,
                         start_at:                  DateTime.now,
                         end_at:                    (DateTime.now + 2.hours),
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    80,
                         city:                      "NewYork")
ticket7.group_prices << [gp_1, gp_2, gp_3]

ticket8 = merchant.tickets.create!(name:            "On Tour Now",
                         desc:                      " You can still score great resale tickets for One Direction!", 
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/e0/f1/341099p1.jpg", 
                         amount:                    1200,
                         category:                  ballet,
                         start_at:                  DateTime.now,
                         end_at:                    (DateTime.now + 2.hours),
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    90,
                         city:                      "NewYork")
ticket8.group_prices << [gp_1, gp_2, gp_3]

ticket9 = merchant.tickets.create!(name:                      "The black eyes11", 
                         desc:                      "The Turn Blue World Tour starts September 5! See the Grammy Award winning duo perform in your city.", 
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/a6/81/356598p1.jpg", 
                         amount:                    120, 
                         category:                  music, 
                         start_at:                  DateTime.now, 
                         end_at:                    (DateTime.now + 2.hours), 
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    50,
                         city:                      "NewYork")
ticket9.group_prices << [gp_1, gp_2, gp_3]

                        
ticket10 = merchant.tickets.create!(name:                      "NFL ticket exchange11",
                         desc:                      " Buy & sell tickets the NFL-approved way.",
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/1c/be/363423p1.jpg",
                         amount:                    120,
                         category:                  orchestra,
                         start_at:                  DateTime.now,
                         end_at:                    (DateTime.now + 2.hours),
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    100,
                         city:                      "NewYork")
ticket10.group_prices << [gp_1, gp_2, gp_3]

ticket11 = merchant.tickets.create!(name:                      "On Tour Now11",
                         desc:                      " You can still score great resale tickets for One Direction!",
                         remote_image_url:          "http://media.ticketmaster.com/img/mw/images/e0/f1/341099p1.jpg",
                         amount:                    120,
                         category:                  dance,
                         start_at:                  DateTime.now,
                         end_at:                    (DateTime.now + 2.hours),
                         minimum_amount:            5,
                         shipping:                  5,
                         oprice:                    100,
                         city:                      "NewYork")
ticket11.group_prices << [gp_1, gp_2, gp_3]

merchant_info = MerchantInfo.create!(user_id: merchant.id,
                                    ticket_id: ticket1.id,
                                    latitude: -34.397,
                                    longitude: 150.644, 
                                    url: Faker::Internet.url,
                                    workday_opening_time: '7:00 am - 10:00 pm',
                                    sat_opening_time: '9:00 am - 6:00 pm',
                                    sun_opening_time: '10:00 am - 10:30 pm',
                                    category_id: 1,
                                    orgnization: 'Merchant',
                                    phone: 1234567890,
                                    sales_phone: 1234567890,
                                    sales_email:'sales@email.com')
  
user_info = UserInfo.create!(user_id:    merchant.id,
                             phone:      Faker::PhoneNumber.phone_number,
                             address:    Faker::Address.street_address,
                             zipcode:    Faker::Address.zip,
                             group_name: Faker::Company.name,
                             is_student: true)
