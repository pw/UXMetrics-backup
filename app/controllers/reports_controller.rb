class ReportsController < UnauthenticatedController
  layout 'authentication'
  before_action :set_study, :set_session_id, :set_paths, :check_for_private
  before_action :check_for_password, only: :show

  def show
    session[@session_id] = nil
    render layout: 'public_report'
  end

  def login    
    redirect_to @reports_path and return unless @study.password_protect_report
     
    if request.post? 
      redirect_to @login_path, notice: 'Incorrect password.' and return if @study.report_password == ''
      if @study.report_password == params[:password] 
        session[@session_id] = 1
        cookies.encrypted[@session_id] = 1 if (params[:remember_me] == 1)
        redirect_to @report_path and return
      end
    else 
      render
    end
  end

  private

  def check_for_private
    redirect_to not_found_path if @study.report_private && !@study.password_protect_report
  end

  def check_for_password
    if @study.password_protect_report
      session[@session_id] = 1 if cookies.encrypted[@session_id]
      redirect_to @login_path unless session[@session_id]
    end
  end
end
