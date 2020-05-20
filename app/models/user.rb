class User < ApplicationRecord
  include Sjabloon::Stripe::Payer
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :masqueradable,
         :trackable

  has_person_name

  validates :name, presence: true

  has_many :cardtests
  has_many :tree_tests
  has_many :card_sorts

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end


  after_create :send_welcome_mail, :after_database_authentication

  def send_welcome_mail


    Analytics.track(
    user_id: self.id,
    event: 'Signed Up')

    puts "!!!!!!!!!!!!!!!sellf is below!!!!!!!!!!!!!!!"
    puts self
    UserNotifierMailer.send_signup_email(self).deliver_later
  end

  def after_database_authentication
    tracker = Mixpanel::Tracker.new(ENV["PROJECT_TOKEN"])
    tracker.people.set(self.id, {
        '$first_name'       => self.first_name,
        '$last_name'        => self.last_name,
        '$email'            => self.email
    }, ip = 0, {'$ignore_time' => 'true'});

    puts "login"

    Analytics.identify(
    user_id: self.id,
    traits: { email: "#{ self.email }", first_name: "#{ self.first_name }", last_name: "#{ self.last_name }", logins: "#{ self.sign_in_count }", trial: "#{ self.trialend }" });

  end

end
