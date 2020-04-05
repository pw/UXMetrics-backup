class TreeTestParticipant < ApplicationRecord
  belongs_to :tree_test
  has_many :tree_test_participant_results, dependent: :destroy

  accepts_nested_attributes_for :tree_test_participant_results
end
