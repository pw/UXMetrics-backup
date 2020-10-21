class User < ApplicationRecord
  has_secure_password

  has_many :email_verifications 
  has_many :password_resets 
  has_many :cardtests
  has_many :tree_tests
  has_many :card_sorts
end
