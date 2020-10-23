class CardSortParticipant < ApplicationRecord
  belongs_to :card_sort
  has_many :card_sort_sorts, dependent: :destroy

  accepts_nested_attributes_for :card_sort_sorts

  before_create do
    if card_sort.card_sort_participants.count == 0
      self.participant_id = 1
    else
      self.participant_id = card_sort.card_sort_participants.order(:participant_id).last.participant_id + 1
    end
  end  

  after_create :send_notification_email

  def send_notification_email
    PostmarkEmailJob.perform_later(card_sort.user.email, 'first-participant', {study_name: card_sort.name, study_report_url: Rails.application.routes.url_helpers.report_card_sort_url(card_sort)}) if participant_id == 1      
  end

  def sorting
    h = card_sort_sorts.includes(:card_sort_group).map{|i| i.card_sort_group}.uniq.sort.each_with_object(Hash.new){|i, h| h[i.name] = []}
    card_sort_sorts.includes(:card_sort_group, :card_sort_card).each{|i| h[i.card_sort_group.name] << i.card_sort_card.title}
    h
  end

  def time_to_complete
    result = ""

    if (minutes = time.to_i / 60000) != 0
      result << "#{minutes}m " 
    else
      seconds = ((time % 60000) / 1000).round
      result << "#{seconds}s"
    end

    result    
  end

  def as_json(*)
    super.tap do |hash|
      hash[:time_to_complete] = time_to_complete
      hash[:sorting] = sorting.to_a
    end
  end

end
