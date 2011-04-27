if Rails.env != "test"
  require 'tlsmail'    
  Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,  
    :address            => 'smtp.mail.com',
    :port               => 587,
    :tls                  => true,
    :domain             => 'mail.com', #you can also use google.com
    :authentication     => :plain,
    :user_name          => 'amigosenapuros@mail.com',
    :password           => '@amigoskatwijk'
  }
end