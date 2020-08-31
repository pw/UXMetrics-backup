class CardSortGroup < ApplicationRecord
  belongs_to :card_sort
  has_many :card_sort_sorts
  has_many :card_sort_cards, through: :card_sort_sorts
  has_many :merged_groups, class_name: 'CardSortGroup', foreign_key: 'merged_group_id'

  def <=>(other)
    if order && other.order
      order <=> other.order
    elsif order
      -1
    elsif other.order
      +1
    else
      created_at <=> other.created_at
    end
  end 
end
