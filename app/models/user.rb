class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :masqueradable,
         :trackable

  has_many :cardtests
  has_many :tree_tests
  has_many :card_sorts

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  after_create :send_welcome_mail

  def send_welcome_mail
    UserNotifierMailer.send_signup_email(self).deliver_later
  end


end
