class CardSortCard < ApplicationRecord
  belongs_to :card_sort
  has_many :card_sort_sorts
  has_many :card_sort_groups, through: :card_sort_sorts
end
