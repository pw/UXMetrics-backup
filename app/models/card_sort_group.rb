class CardSortGroup < ApplicationRecord
  belongs_to :card_sort
  has_many :card_sort_sorts
  has_many :card_sort_cards, through: :card_sort_sorts
  has_many :merged_groups, class_name: 'CardSortGroup', foreign_key: 'merged_group_id'
end
