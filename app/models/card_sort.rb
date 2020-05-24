class CardSort < ApplicationRecord
  belongs_to :user
  has_many :card_sort_groups, dependent: :destroy
  has_many :card_sort_cards, dependent: :destroy
  has_many :card_sort_participants, dependent: :destroy
  has_many :card_sort_sorts, dependent: :destroy

  accepts_nested_attributes_for :card_sort_groups, allow_destroy: true
  accepts_nested_attributes_for :card_sort_cards, allow_destroy: true

  before_create :add_auth_token

  def median_time
    return nil if card_sort_participants.where(excluded: false).count == 0
    card_
    card_sort_participants.where(excluded: false).sum{|i| i.time} / card_sort_participants.where(excluded: false).count
  end

  def median_time_formatted
    return 'n/a' if card_sort_participants.where(excluded: false).count == 0
    result = ""

    if (minutes = median_time.to_i / 60000) != 0
      result << "#{minutes}m " 
    else
      seconds = ((median_time % 60000) / 1000).round
      result << "#{seconds}s"
    end

    result
  end  

  def as_json(*)
    super.tap do |hash| 
      hash[:created_at_day] = created_at.strftime('%-m/%-d/%Y')
      hash[:collect_url] = Rails.application.routes.url_helpers.card_sort_collect_url(auth_token: auth_token, host: ENV['CURRENT_HOST'])
      hash[:logo_url] = "https://#{ENV['LOGO_UPLOAD_ENDPOINT']}/#{logo_key}"
      hash[:results_count] = 0 
      hash[:test_results_count] = card_sort_participants.where(excluded: false).count
      hash[:median_time] = median_time_formatted
      hash[:total_groups] = card_sort_groups.count
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
