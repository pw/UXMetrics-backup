class TreeTestTask < ApplicationRecord
  belongs_to :tree_test
  has_many :tree_test_participant_results
end
