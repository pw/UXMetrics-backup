class CardSortGroup < ApplicationRecord
  belongs_to :card_sort
  has_many :card_sort_sorts
  has_many :card_sort_cards, through: :card_sort_sorts
end
