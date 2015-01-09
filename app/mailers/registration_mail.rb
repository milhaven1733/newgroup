class RegistrationMail < ApplicationMailer
  default from: 'notifications@example.com'

  def new_venue_notification user
    delivery_options = { user_name: company.smtp_user,
                         password: company.smtp_password,
                         address: company.smtp_host }
    mail(to: email,
         subject: "New venue: #{user.email} is now waiting for verification",
         delivery_method_options: delivery_options)
  end
end
