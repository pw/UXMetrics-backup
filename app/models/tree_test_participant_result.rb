class TreeTestParticipantResult < ApplicationRecord
  belongs_to :tree_test_participant
  belongs_to :tree_test_task

  before_create do
    self.outcome = determine_outcome
  end

  def success?
    correct_choices.include?(choice) && !skip
  end

  def failure?
    !correct_choices.include?(choice) && !skip
  end

  def correct_choices
    tree_test_task.tree_test_task_correct_choices.map{|i| i.node}
  end

  def time_formatted
    result = ""

    if (minutes = time.to_i / 60000) != 0
      result << "#{minutes}m " 
    else
      seconds = ((time % 60000) / 1000).round
      result << "#{seconds}s"
    end

    result    
  end

  def determine_outcome
    if success? && direct
      return 'direct_correct'
    elsif success? && !direct
      return 'indirect_correct'
    elsif failure? && direct
      return 'direct_incorrect'
    elsif failure? && !direct
      return 'indirect_incorrect'
    elsif skip && direct
      return 'direct_skip'
    elsif skip && !direct
      return 'indirect_skip'
    end
  end

  def as_json(*)
    super.tap do |hash|
      hash[:outcome] = outcome
      hash[:time_formatted] = time_formatted
    end
  end

end
