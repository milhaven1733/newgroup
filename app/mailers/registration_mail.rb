class RegistrationMail < ApplicationMailer
  default from: APP_CONFIG[:MAILER_SENDER]

  def new_venue_notification user

    delivery_options = { user_name: APP_CONFIG[:MAILER_SENDER],
                         password: APP_CONFIG[:MAILER_PASSWORD],
                         address: APP_CONFIG[:MAILER_SMTP] }
    mail(to: APP_CONFIG[:MAILER_RECIEVER],
         subject: "GroupEt New Venue Notification, New venue: #{user.email} is now waiting for verification",
         body: "Hi, dear admin users. A new venue account has been created just now. It's #{user.email}, please log in your admin account and upgrade it!",
         delivery_method_options: delivery_options)
  end
end
