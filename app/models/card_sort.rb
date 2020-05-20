class CardSort < ApplicationRecord
  belongs_to :user
  has_many :card_sort_groups, dependent: :destroy
  has_many :card_sort_cards, dependent: :destroy

  accepts_nested_attributes_for :card_sort_groups, allow_destroy: true
  accepts_nested_attributes_for :card_sort_cards, allow_destroy: true

  before_create :add_auth_token

  def as_json(*)
    super.tap do |hash| 
      hash[:created_at_day] = created_at.strftime('%-m/%-d/%Y')
      #hash[:collect_url] = Rails.application.routes.url_helpers.tree_test_collect_url(auth_token: auth_token, host: ENV['CURRENT_HOST'])
      hash[:logo_url] = "https://#{ENV['LOGO_UPLOAD_ENDPOINT']}/#{logo_key}"
      hash[:results_count] = 0 
    end
  end

  private
  def add_auth_token  
    auth_token = SecureRandom.alphanumeric(ENV['SHORTENER_STARTING_KEY_LENGTH'].to_i)
    while TreeTest.find_by(auth_token: auth_token)
      auth_token = SecureRandom.alphanumeric(auth_token.length + 1)
    end
    self.auth_token = auth_token    
  end
end
