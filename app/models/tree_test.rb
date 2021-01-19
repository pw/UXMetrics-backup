class TreeTest < ApplicationRecord  
  belongs_to :user
  has_many :tree_test_tasks, dependent: :destroy
  has_many :tree_test_participants, dependent: :destroy

  accepts_nested_attributes_for :tree_test_tasks, allow_destroy: true

  before_create :add_auth_token, :add_report_token
  before_update do 
    @publication = true if (status_changed? && status == 'published')
  end
  before_update :gate_premium_features
  before_create do 
    self.tree_test_tasks.build(order: 0)
  end
  after_commit :send_publication_notice

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

  def collect_url
    Rails.application.routes.url_helpers.tree_test_collect_url(auth_token: auth_token) if auth_token
  end

  def logo_url
    if logo_key == '' 
      ActionController::Base.helpers.asset_pack_path('media/images/uxmetrics-logo-full.svg')
    else 
      "https://#{ENV['LOGO_UPLOAD_ENDPOINT']}/#{logo_key}?auto=compress"
    end   
  end

  def as_json(*)
    super.tap do |hash|
      hash[:created_at_day] = created_at&.strftime('%-m/%-d/%Y')
      hash[:collect_url] = collect_url
      hash[:logo_base_url] = "https://#{ENV['LOGO_UPLOAD_ENDPOINT']}"
      hash[:logo_url] = logo_url
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
      hash[:subscribed] = user.subscribed
      hash[:edit_url] = Rails.application.routes.url_helpers.edit_tree_test_url(self) if id
      hash[:user_id] = user.id
      hash[:tree_test_tasks] = tree_test_tasks.order(:order)
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

    def add_report_token  
      token = SecureRandom.alphanumeric(ENV['SHORTENER_STARTING_KEY_LENGTH'].to_i)
      while TreeTest.find_by(report_token: token)
        token = SecureRandom.alphanumeric(auth_token.length + 1)
      end
      self.report_token = token    
    end   

    def send_publication_notice
      PostmarkEmailJob.perform_later(user.email, 'published-study', {study_name: name, study_url: collect_url}) if @publication
    end 

    def gate_premium_features
      unless user.subscribed
        self.randomize_tree_order = false if randomize_tree_order_changed?
        self.randomize_task_order = false if randomize_task_order_changed?
        self.allow_skip = false if allow_skip_changed?
        self.logo_key = '' if logo_key_changed?
        self.report_private = false if report_private_changed?
        self.password_protect_report = false if password_protect_report_changed?
        self.report_password = nil if report_password_changed?
      end
    end      
end
