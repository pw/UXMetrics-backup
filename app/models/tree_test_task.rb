class TreeTestTask < ApplicationRecord
  belongs_to :tree_test
  has_many :tree_test_participant_results, dependent: :destroy
  has_many :tree_test_task_correct_choices, dependent: :destroy

  accepts_nested_attributes_for :tree_test_task_correct_choices

  def correct_choices
    tree_test_task_correct_choices.map{|i| i.node}
  end

  def results_success
    tree_test_participant_results.where(choice: correct_choices)
  end

  def percent_success    
    results_success.count.to_f / tree_test_participant_results.count.to_f
  end

  def percent_success_formatted
    "#{(percent_success * 100).round}%"
  end

  def median_time
    tree_test_participant_results.sum{|i| i.time}.to_f / tree_test_participant_results.count.to_f
  end

  def median_time_formatted
    result = ""

    if (minutes = median_time.to_i / 60000) != 0
      result << "#{minutes}m " 
    else
      seconds = ((median_time % 60000) / 1000).round
      result << "#{seconds}s"
    end

    result    
  end

  def directness
    tree_test_participant_results.select{|i| i.direct}.count.to_f / tree_test_participant_results.count.to_f
  end

  def directness_formatted
    "#{(directness * 100).round}%"
  end

  ### START Direct Correct ###

  def results_direct_correct
    tree_test_participant_results.where(choice: correct_choices, direct: true, skip: false)
  end

  def percent_navigated_directly_to_correct
    results_direct_correct.count.to_f / tree_test_participant_results.count.to_f
  end

  def percent_navigated_directly_to_correct_rounded
    (percent_navigated_directly_to_correct * 100).round(1)
  end

  ### END DIRECT CORRECT ###

  ### START INDIRECT CORRECT ###

  def results_indirect_correct
    tree_test_participant_results.where(choice: correct_choices, direct: false, skip: false)
  end

  def percent_navigated_indirectly_to_correct
    results_indirect_correct.count.to_f / tree_test_participant_results.count.to_f
  end  

  def percent_navigated_indirectly_to_correct_rounded
    (percent_navigated_indirectly_to_correct * 100).round(1)
  end

  def results_summary_indirect_correct
    total_results = results_indirect_correct.count
    results = results_indirect_correct.group(:path).count.sort{|a,b| b.last - a.last}.first(3)

    results.each do |result|
      result[1] = ((result.last.to_f / total_results.to_f) * 100).round(1)
    end

    results
  end

  ### END INDIRECT CORRECT ###

  ### START DIRECT INCORRECT

  def results_direct_incorrect
    tree_test_participant_results.where(direct: true, skip: false).where.not(choice: correct_choices)    
  end

  def percent_navigated_directly_to_incorrect
    results_direct_incorrect.count.to_f / tree_test_participant_results.count.to_f
  end

  def percent_navigated_directly_to_incorrect_rounded
    (percent_navigated_directly_to_incorrect * 100).round(1)
  end

  def results_summary_direct_incorrect
    total_results = results_direct_incorrect.count
    results = results_direct_incorrect.group(:path).count.sort{|a,b| b.last - a.last}.first(3)

    results.each do |result|
      result[1] = ((result.last.to_f / total_results.to_f) * 100).round(1)
    end

    results
  end

  ### END DIRECT INCORRECT ###

  ### START INDIRECT INCORRECT ###

  def results_indirect_incorrect
    tree_test_participant_results.where(direct: false, skip: false).where.not(choice: correct_choices)
  end

  def percent_navigated_indirectly_to_incorrect
    results_indirect_incorrect.count.to_f / tree_test_participant_results.count.to_f
  end

  def percent_navigated_indirectly_to_incorrect_rounded
    (percent_navigated_indirectly_to_incorrect * 100).round(1)
  end

  def results_summary_indirect_incorrect
    total_results = results_indirect_incorrect.count
    results = results_indirect_incorrect.group(:path).count.sort{|a,b| b.last - a.last}.first(3)

    results.each do |result|
      result[1] = ((result.last.to_f / total_results.to_f) * 100).round(1)
    end

    results
  end  
  ### END INDIRECT INCORRECT ###

  ### START SKIPPED DIRECT ###
  def results_skipped_directly
    tree_test_participant_results.where(skip: true, direct: true)
  end

  def percent_skipped_directly
    tree_test_participant_results.select{|i| i.skip && i.direct}.count.to_f / tree_test_participant_results.count.to_f
  end

  def percent_skipped_directly_rounded
    (percent_skipped_directly * 100).round(1)
  end
  ### END SKIPPED DIRECT ###

  ### START SKIPPED INDIRECT ###
  def results_skipped_indirect
    tree_test_participant_results.where(skip: true, direct: false)
  end

  def percent_skipped_indirectly
    results_skipped_indirect.count.to_f / tree_test_participant_results.count.to_f
  end

  def percent_skipped_indirectly_rounded
    (percent_skipped_indirectly * 100).round(1)
  end

  def results_summary_skipped_indirect
    total_results = results_skipped_indirect.count
    results = results_skipped_indirect.group(:path).count.sort{|a,b| b.last - a.last}.first(3)

    results.each do |result|
      result[1] = ((result.last.to_f / total_results.to_f) * 100).round(1)
    end

    results
  end
  ### END SKIPPED INDIRECT ### 

end
