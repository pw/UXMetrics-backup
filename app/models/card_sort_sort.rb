class CardSortSort < ApplicationRecord
  belongs_to :card_sort
  belongs_to :card_sort_participant
  belongs_to :card_sort_group
  belongs_to :card_sort_card
end
