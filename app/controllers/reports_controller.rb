class ReportsController < UnauthenticatedController
  layout 'authentication'
  skip_before_action :check_for_login
  before_action :check_for_tt_password, only: :tree_tests
  before_action :check_for_cs_password, only: :card_sorts

  def tree_tests    
    @tree_test = TreeTest.where(report_token: params[:token]).includes(tree_test_tasks: :tree_test_task_correct_choices)
    session["tt_#{params[:token]}"] = nil
    render layout: 'public_report'
  end

  def new_tt_login
    @tree_test = TreeTest.find_by(report_token: params[:token])
    return redirect_to not_found_path if @tree_test.report_private
    @logo_url = @tree_test.logo_url
  end

  def tt_login
    if TreeTest.find_by(report_token: params[:token]).report_password == params[:password]
      session["tt_#{params[:token]}"] = 1 
      cookies.encrypted["tt_#{params[:token]}"] = 1 if (params[:remember_me] == '1')
      redirect_to tree_test_public_report_path
    else 
      redirect_to reports_new_tt_login_path, notice: 'Incorrect password.'
    end
  end

  def card_sorts
    @card_sort = CardSort.where(report_token: params[:token]).first
    session["cs_#{params[:token]}"] = nil
    render layout: 'public_report'
  end

  def new_cs_login
    @card_sort = CardSort.find_by(report_token: params[:token])
    return redirect_to not_found_path if @card_sort.report_private
    @logo_url = @card_sort.logo_url    
  end

  def cs_login
    if CardSort.find_by(report_token: params[:token]).report_password == params[:password]
      session["cs_#{params[:token]}"] = 1 
      cookies.encrypted["cs_#{params[:token]}"] = 1 if (params[:remember_me] == '1')
      redirect_to card_sort_public_report_path
    else 
      redirect_to reports_new_cs_login_path, notice: 'Incorrect password.'
    end
  end  

  private
  def check_for_tt_password
    @tree_test = TreeTest.find_by(report_token: params[:token])
    if @tree_test.report_private
      redirect_to not_found_path
    elsif @tree_test.password_protect_report
      session["tt_#{params[:token]}"] = 1 if cookies.encrypted["tt_#{params[:token]}"]
      redirect_to reports_new_tt_login_path unless session["tt_#{params[:token]}"]
    end
  end

  def check_for_cs_password
    @card_sort = CardSort.find_by(report_token: params[:token])
    if @card_sort.report_private
      redirect_to not_found_path
    elsif @card_sort.password_protect_report
      session["cs_#{params[:token]}"] = 1 if cookies.encrypted["cs_#{params[:token]}"]
      redirect_to reports_new_cs_login_path unless session["cs_#{params[:token]}"]
    end
  end

end
