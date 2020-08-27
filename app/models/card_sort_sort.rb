class CardSortSort < ApplicationRecord
  belongs_to :card_sort
  belongs_to :card_sort_participant
  belongs_to :card_sort_group
  belongs_to :card_sort_card

  before_create do
    if merge_id = card_sort_group.merged_group_id
      self.pre_merge_group_id = card_sort_group.id
      self.card_sort_group_id = merge_id
    end
  end
end
