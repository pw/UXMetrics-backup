class CardSort < ApplicationRecord
  belongs_to :user
  has_many :card_sort_sorts, dependent: :destroy
  has_many :card_sort_groups, dependent: :destroy
  has_many :card_sort_cards, dependent: :destroy
  has_many :card_sort_participants, dependent: :destroy
  
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

  def excluded_participant_ids
    card_sort_participants.where(excluded: true).map{|i| i.id}
  end

  def card_results
    result = Hash.new{|hash,k| hash[k] = {groups: [], agreement_score: nil}}
    card_sort_cards.joins(card_sort_sorts: :card_sort_group).where.not(card_sort_sorts: {card_sort_participant_id: excluded_participant_ids}).group(:card_sort_card_id).group(:card_sort_group_id).count.each do |(k,v)| 
      result[k.first][:groups] << [CardSortGroup.find(k.last).name, v]
    end
    result.each do |k, v|
      v[:name] = CardSortCard.find(k).title 
      v[:groups].sort!{|a, b| b.second <=> a.second}
      v[:agreement_score] = ((v[:groups].first.second / v[:groups].sum{|i| i.second}.to_f) * 100).round(0)
    end
    result.to_a.sort{|a,b| CardSortCard.find(a.first).order <=> CardSortCard.find(b.first).order}
  end

  def group_results
    result = Hash.new{|hash,k| hash[k] = {cards: [], created_by: nil}}
    card_sort_groups.joins(card_sort_sorts: :card_sort_card).where.not(card_sort_sorts: {card_sort_participant_id: excluded_participant_ids}).group(:card_sort_group_id).group(:card_sort_card_id).count.each do |(k,v)| 
      result[k.first][:cards] << [CardSortCard.find(k.last).title, v]
    end    
    result.each do |k, v|
      group = CardSortGroup.find(k)
      v[:name] = group.name
      v[:cards].sort!{|a, b| b.second <=> a.second}
      v[:created_by] = CardSortGroup.where(id: k).joins(:card_sort_sorts).where.not(card_sort_sorts: {card_sort_participant_id: excluded_participant_ids}).select('card_sort_participant_id').distinct.count
      v[:merged_groups] = group.merged_groups
    end
    result.to_a.sort{|a, b| CardSortGroup.find(a.first) <=> CardSortGroup.find(b.first)}
  end

  def distribution_of_groups_created_per_participant
    card_sort_groups.joins(card_sort_sorts: :card_sort_participant).where(card_sort_participants: {excluded: false}).group(:card_sort_participant_id).distinct.count(:card_sort_group_id).each_with_object(Hash.new(0)){|(k,v),h| h[v] += 1}.to_a.sort{|a,b| a.first <=> b.first}
  end

  def sankey_data
    data = card_sort_sorts.joins(:card_sort_participant).where(card_sort_participants: {excluded: false}).group(:card_sort_group_id).group(:card_sort_card_id).count.map{|(a,b),v| [CardSortGroup.find(a), CardSortCard.find(b), v]}.sort{|a,b| ((a.first <=> b.first) == 0 ? (a.second.order <=> b.second.order) : (a.first <=> b.first))}.map{|i| [i.first.name, i.second.title, i[2]]}
    [['From', 'To', 'Weight']] + data
  end

  def participants
    card_sort_participants.map{|i| [i.participant_id, i.id]}
  end

  def card_sort_cards_randomized_or_not
    if randomize_card_order
      card_sort_cards.to_a.shuffle
    else
      card_sort_cards.order(:order)
    end
  end

  def as_json(*)
    super.tap do |hash| 
      hash[:created_at_day] = created_at.strftime('%-m/%-d/%Y')
      hash[:collect_url] = Rails.application.routes.url_helpers.card_sort_collect_url(auth_token: auth_token, host: ENV['CURRENT_HOST'])
      hash[:logo_base_url] = "https://#{ENV['LOGO_UPLOAD_ENDPOINT']}"
      hash[:logo_url] = (logo_key != 'undefined') ? "https://#{ENV['LOGO_UPLOAD_ENDPOINT']}/#{logo_key}" : ActionController::Base.helpers.asset_pack_path('media/images/uxops-logo.svg')
      hash[:results_count] = card_sort_participants.where(excluded: false).count
      hash[:test_results_count] = card_sort_participants.where(excluded: false).count
      hash[:median_time] = median_time_formatted
      hash[:total_groups] = card_sort_groups.count
      hash[:card_sort_groups] = card_sort_groups.where.not(order: nil).order(:order)
      hash[:card_sort_cards] = card_sort_cards_randomized_or_not
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
