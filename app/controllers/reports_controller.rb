class ReportsController < UnauthenticatedController
  layout 'authentication'
  skip_before_action :check_for_login
  before_action :check_for_tt_password, only: :tree_tests

  def tree_tests    
    @tree_test = TreeTest.where(report_token: params[:token]).includes(tree_test_tasks: :tree_test_task_correct_choices)
    session[params[:token]] = ''
    render layout: 'dashboard'
  end

  def tt_login
    if TreeTest.find_by(report_token: params[:token]).try(:authenticate, params[:password])
      session[params[:token]] = 1 
      cookies.encrypted[params[:token]] = 1 if (params[:remember_me] == '1')
      redirect_to tree_test_public_report_path
    else 
      redirect_to reports_new_tt_login_path, notice: 'Incorrect password.'
    end
  end

  private
  def check_for_tt_password
    if TreeTest.find_by(report_token: params[:token]).user.subscribed
      session[params[:token]] = 1 if cookies.encrypted[params[:token]]
      redirect_to reports_new_tt_login_path unless session[params[:token]]
    end
  end

end
