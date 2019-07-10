class Cardtest < ApplicationRecord
  has_many :cards, inverse_of: :cardtest
  has_many :results
  accepts_nested_attributes_for :cards, allow_destroy:true
  before_validation :mark_cards_for_destruction

  def mark_cards_for_destruction
    cards.each do |card|
      if card.name.blank?
        card.mark_for_destruction
      end
    end
  end


  belongs_to :user
  # has_secure_token
  # has_secure_token :uid

  has_unique_field :uid, length: 8
  has_unique_field :auth_token, length: 8

  # before_create :set_access_token


  # extend FriendlyId
  # friendly_id :name, use: :slugged

  def to_param
    uid
  end

  private

  # def set_access_token
  #   self.access_token = generate_token
  # end
  #
  # def generate_token
  #   loop do
  #     auth_token = SecureRandom.hex(5)
  #     break auth_token unless User.where(access_token: auth_token).exists?
  #   end
  # end


end
