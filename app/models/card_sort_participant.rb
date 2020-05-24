class CardSortParticipant < ApplicationRecord
  belongs_to :card_sort

  before_create do
    if card_sort.card_sort_participants.count == 0
      self.participant_id = 1
    else
      self.participant_id = card_sort.card_sort_participants.order(:participant_id).last.participant_id + 1
    end
  end  
end
