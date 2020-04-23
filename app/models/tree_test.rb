class TreeTest < ApplicationRecord
  belongs_to :user
  has_many :tree_test_tasks, dependent: :destroy
  has_many :tree_test_participants, dependent: :destroy
  
  has_secure_token :auth_token

  accepts_nested_attributes_for :tree_test_tasks, allow_destroy: true

  def participants(offset = 0)
    tree_test_participants.order(:id).limit(10).offset(offset)
  end

  def percent_success
    return nil if tree_test_participants.count == 0
    tree_test_tasks.sum{|i| i.percent_success} / tree_test_tasks.count.to_f
  end

  def median_time
    return nil if tree_test_participants.count == 0
    tree_test_tasks.sum{|i| i.median_time}
  end

  def median_time_formatted
    return nil if tree_test_participants.count == 0
    result = ""

    if (minutes = median_time.to_i / 60000) != 0
      result << "#{minutes}m " 
    else
      seconds = ((median_time % 60000) / 1000).round
      result << "#{seconds}s"
    end

    result
  end

  def percent_navigated_directly_to_correct
    return nil if tree_test_participants.count == 0
    tree_test_tasks.sum{|i| i.percent_navigated_directly_to_correct} / tree_test_tasks.count.to_f  
  end  

  def percent_navigated_indirectly_to_correct
    return nil if tree_test_participants.count == 0
    tree_test_tasks.sum{|i| i.percent_navigated_indirectly_to_correct} / tree_test_tasks.count.to_f  
  end  

  def percent_navigated_directly_to_incorrect
    return nil if tree_test_participants.count == 0
    tree_test_tasks.sum{|i| i.percent_navigated_directly_to_incorrect} / tree_test_tasks.count.to_f  
  end 

  def percent_navigated_indirectly_to_incorrect
    return nil if tree_test_participants.count == 0
    tree_test_tasks.sum{|i| i.percent_navigated_indirectly_to_incorrect} / tree_test_tasks.count.to_f  
  end  

  def percent_skipped_directly
    return nil if tree_test_participants.count == 0
    tree_test_tasks.sum{|i| i.percent_skipped_directly} / tree_test_tasks.count.to_f  
  end 

  def percent_skipped_indirectly
    return nil if tree_test_participants.count == 0
    tree_test_tasks.sum{|i| i.percent_skipped_indirectly} / tree_test_tasks.count.to_f  
  end

  def as_json(*)
    super.tap do |hash|
      hash[:created_at_day] = created_at.strftime('%-m/%-d/%Y')
      hash[:collect_url] = Rails.application.routes.url_helpers.tree_test_collect_url(auth_token: auth_token, host: 'http://localhost:4000')
      hash[:test_results_count] = tree_test_participants.count
      hash[:percent_success] = percent_success && (percent_success * 100).round
      hash[:median_time] = median_time_formatted
      hash[:percent_navigated_directly_to_correct] = percent_navigated_directly_to_correct && (percent_navigated_directly_to_correct * 100).round(1)      
      hash[:percent_navigated_indirectly_to_correct] = percent_navigated_indirectly_to_correct && (percent_navigated_indirectly_to_correct * 100).round(1)      
      hash[:percent_navigated_directly_to_incorrect] = percent_navigated_directly_to_incorrect && (percent_navigated_directly_to_incorrect * 100).round(1)
      hash[:percent_navigated_indirectly_to_incorrect] = percent_navigated_indirectly_to_incorrect && (percent_navigated_indirectly_to_incorrect * 100).round(1)
      hash[:percent_skipped_directly] = percent_skipped_directly && (percent_skipped_directly * 100).round(1)
      hash[:percent_skipped_indirectly] = percent_skipped_indirectly && (percent_skipped_indirectly * 100).round(1) 
    end
  end
end
