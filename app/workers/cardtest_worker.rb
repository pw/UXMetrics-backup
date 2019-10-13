class CardtestWorker
  include Sidekiq::Worker



  def perform(email)
    puts "EOOO BITCH"
    UserNotifierMailer.send_signup_email(email).deliver
  end
end
