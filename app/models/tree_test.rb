class TreeTest < ApplicationRecord
  belongs_to :user
  has_many :tree_test_tasks, dependent: :destroy
  has_many :tree_test_participants, dependent: :destroy

  accepts_nested_attributes_for :tree_test_tasks, allow_destroy: true

  before_create :add_auth_token

  def participants(offset = 0)
    tree_test_participants.order(:id).limit(1).offset(offset)
  end

  def percent_success
    return nil if tree_test_participants.where(excluded: false).count == 0
    tree_test_tasks.sum{|i| i.percent_success} / tree_test_tasks.count.to_f
  end

  def percent_success_rounded
    return 0 if tree_test_participants.where(excluded: false).count == 0
    (percent_success * 100).round
  end

  def median_time
    return nil if tree_test_participants.where(excluded: false).count == 0
    tree_test_tasks.sum{|i| i.median_time}
  end

  def median_time_formatted
    return nil if tree_test_participants.where(excluded: false).count == 0
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
    return nil if tree_test_participants.where(excluded: false).count == 0
    tree_test_tasks.sum{|i| i.percent_navigated_directly_to_correct} / tree_test_tasks.count.to_f  
  end  

  def percent_navigated_indirectly_to_correct
    return nil if tree_test_participants.where(excluded: false).count == 0
    tree_test_tasks.sum{|i| i.percent_navigated_indirectly_to_correct} / tree_test_tasks.count.to_f  
  end  

  def percent_navigated_directly_to_incorrect
    return nil if tree_test_participants.where(excluded: false).count == 0
    tree_test_tasks.sum{|i| i.percent_navigated_directly_to_incorrect} / tree_test_tasks.count.to_f  
  end 

  def percent_navigated_indirectly_to_incorrect
    return nil if tree_test_participants.where(excluded: false).count == 0
    tree_test_tasks.sum{|i| i.percent_navigated_indirectly_to_incorrect} / tree_test_tasks.count.to_f  
  end  

  def percent_skipped_directly
    return nil if tree_test_participants.where(excluded: false).count == 0
    tree_test_tasks.sum{|i| i.percent_skipped_directly} / tree_test_tasks.count.to_f  
  end 

  def percent_skipped_indirectly
    return nil if tree_test_participants.where(excluded: false).count == 0
    tree_test_tasks.sum{|i| i.percent_skipped_indirectly} / tree_test_tasks.count.to_f  
  end

  def as_json(*)
    super.tap do |hash|
      hash[:created_at_day] = created_at.strftime('%-m/%-d/%Y')
      hash[:collect_url] = Rails.application.routes.url_helpers.tree_test_collect_url(auth_token: auth_token, host: ENV['CURRENT_HOST'])
      hash[:logo_base_url] = "https://#{ENV['LOGO_UPLOAD_ENDPOINT']}"
      hash[:logo_url] = (logo_key != 'undefined') ? "https://#{ENV['LOGO_UPLOAD_ENDPOINT']}/#{logo_key}" : ActionController::Base.helpers.asset_pack_path('media/images/uxops-logo.svg')
      hash[:test_results_count] = tree_test_participants.where(excluded: false).count
      hash[:percent_success] = percent_success_rounded
      hash[:median_time] = median_time_formatted
      hash[:percent_navigated_directly_to_correct] = percent_navigated_directly_to_correct && (percent_navigated_directly_to_correct * 100).round(1)      
      hash[:percent_navigated_indirectly_to_correct] = percent_navigated_indirectly_to_correct && (percent_navigated_indirectly_to_correct * 100).round(1)      
      hash[:percent_navigated_directly_to_incorrect] = percent_navigated_directly_to_incorrect && (percent_navigated_directly_to_incorrect * 100).round(1)
      hash[:percent_navigated_indirectly_to_incorrect] = percent_navigated_indirectly_to_incorrect && (percent_navigated_indirectly_to_incorrect * 100).round(1)
      hash[:percent_skipped_directly] = percent_skipped_directly && (percent_skipped_directly * 100).round(1)
      hash[:percent_skipped_indirectly] = percent_skipped_indirectly && (percent_skipped_indirectly * 100).round(1)
      hash[:total_participants] = tree_test_participants.count 
    end
  end

  private 
    def add_auth_token
      auth_token = SecureRandom.alphanumeric(ENV['SHORTENER_STARTING_KEY_LENGTH'].to_i)
      while TreeTest.find_by(auth_token: auth_token)
        auth_token = SecureRandom.alphanumeric(auth_token.length + 1)
      end
      self.auth_token = auth_token
    end  
end
