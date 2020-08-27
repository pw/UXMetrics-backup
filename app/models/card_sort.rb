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

  def card_results
    result = Hash.new{|hash,k| hash[k] = {groups: [], agreement_score: nil}}
    card_sort_cards.joins(:card_sort_groups).group(:card_sort_card_id).group(:card_sort_group_id).count.each do |(k,v)| 
      result[CardSortCard.find(k.first).title][:groups] << [CardSortGroup.find(k.last).name, v]
    end
    result.each do |k, v| 
      v[:groups].sort!{|a, b| b.second <=> a.second}
      v[:agreement_score] = ((v[:groups].first.second / v[:groups].sum{|i| i.second}.to_f) * 100).round(0)
    end
    result.to_a
  end

  def group_results
    result = Hash.new{|hash,k| hash[k] = {cards: [], created_by: nil}}
    card_sort_groups.where(merged: false).joins(:card_sort_cards).group(:card_sort_group_id).group(:card_sort_card_id).count.each do |(k,v)| 
      result[CardSortGroup.find(k.first).name][:cards] << [CardSortCard.find(k.last).title, v]
    end    
    result.each do |k, v|
      v[:cards].sort!{|a, b| b.second <=> a.second}
      v[:created_by] = card_sort_groups.where(name: k).joins(:card_sort_sorts).select('card_sort_participant_id').distinct.count
      v[:merged_groups] = card_sort_groups.where(name: k).first.merged_groups
    end
    result.to_a.sort{|a, b| b.last[:created_by] <=> a.last[:created_by]}
  end

  def as_json(*)
    super.tap do |hash| 
      hash[:created_at_day] = created_at.strftime('%-m/%-d/%Y')
      hash[:collect_url] = Rails.application.routes.url_helpers.card_sort_collect_url(auth_token: auth_token, host: ENV['CURRENT_HOST'])
      hash[:logo_url] = (logo_key != 'undefined') ? "https://#{ENV['LOGO_UPLOAD_ENDPOINT']}/#{logo_key}" : ActionController::Base.helpers.asset_pack_path('media/images/uxops-logo.svg')
      hash[:results_count] = card_sort_participants.where(excluded: false).count
      hash[:test_results_count] = card_sort_participants.where(excluded: false).count
      hash[:median_time] = median_time_formatted
      hash[:total_groups] = card_sort_groups.count
      hash[:card_sort_groups] = card_sort_groups.where.not(order: nil)
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
