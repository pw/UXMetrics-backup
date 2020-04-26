class TreeTestParticipant < ApplicationRecord
  belongs_to :tree_test
  has_many :tree_test_participant_results, dependent: :destroy

  accepts_nested_attributes_for :tree_test_participant_results

  before_create do
    if tree_test.tree_test_participants.count == 0
      self.participant_id = 1
    else
      self.participant_id = tree_test.tree_test_participants.order(:participant_id).last.participant_id + 1
    end
  end

  before_save do
    tree_test_participant_results.update_all(excluded: excluded)
  end

  def results_success
    tree_test_participant_results.select{|i| i.success? }
  end

  def percent_success
    ((results_success.count.to_f / tree_test_participant_results.count.to_f) * 100).round
  end

  def time_taken
    tree_test_participant_results.sum{|i| i.time}
  end

  def time_taken_formatted
    result = ""

    if (minutes = time_taken.to_i / 60000) != 0
      result << "#{minutes}m " 
    else
      seconds = ((time_taken % 60000) / 1000).round
      result << "#{seconds}s"
    end

    result    
  end

  def tasks_completed
    tree_test_participant_results.where(skip: false)
  end

  def tasks_completed_percent
    ((tasks_completed.count.to_f / tree_test_participant_results.count.to_f) * 100).round
  end

  def results_sorted
    tree_test_participant_results.joins(:tree_test_task).order('tree_test_tasks.task_number')
  end

  def as_json(*)
    super.tap do |hash|
      hash[:success_score] = percent_success
      hash[:time_taken] = time_taken_formatted
      hash[:tasks_completed] = tasks_completed_percent
      hash[:results] = results_sorted
    end
  end

end
