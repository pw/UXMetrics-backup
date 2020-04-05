class TreeTestTask < ApplicationRecord
  belongs_to :tree_test
  has_many :tree_test_participant_results, dependent: :destroy
  has_many :tree_test_task_correct_choices, dependent: :destroy

  accepts_nested_attributes_for :tree_test_task_correct_choices
end
