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

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end


  after_create :send_welcome_mail

  def send_welcome_mail
    puts "!!!!!!!!!!!!!!!sellf is below!!!!!!!!!!!!!!!"
    puts self
    UserNotifierMailer.send_signup_email(self).deliver_later
  end

  def after_database_authentication
    tracker.people.set(current_user.id, {
        '$first_name'       => current_user.first_name,
        '$last_name'        => current_user.last_name,
        '$email'            => current_user.email,
        '$phone'            => '5555555555',
        'Favorite Color'    => 'red'
    }, ip = 0, {'$ignore_time' => 'true'});
  end

end
