class AuthenticationController < UnauthenticatedController
  skip_before_action :check_for_login, only: :logout

  def signup        
    user = User.create(email: params[:email], password: params[:password])
    login_user(user)
    redirect_to dashboard_path

  rescue ActiveRecord::RecordNotUnique
    redirect_to signup_path, notice: 'Unable to create account.'
  end

  def login
    if user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
      login_user(user)
      remember_user(user) if (params[:remember_me] == 1)
      redirect_to dashboard_path, notice: 'Successfully logged in.'
    else
      redirect_to login_path, notice: 'Unable to log in.'
    end
  end

  def logout
    cookies.delete :user_id
    reset_session
    redirect_to root_path, notice: 'You have logged out.'
  end

  def reset_password
    User.find_by(email: params[:email]).password_resets.create
    redirect_to reset_password_path, notice: 'You will receive an email with instructions for how to unlock your account in a few minutes.'
  end

  def new_set_password
    if password_reset = PasswordReset.find_by(token: params[:token])
      if password_reset.created_at > 1.day.ago
        @temp_password = SecureRandom.hex(32)
        @user_id = password_reset.user.id
        password_reset.user.update(password: @temp_password)
        password_reset.destroy
      else 
        password_reset.user.password_resets.create
        password_reset.destroy
        redirect_to root_path, notice: 'Expired password reset. Please check your email for a new one.'
      end
    else
      redirect_to reset_password_path, notice: 'Invalid password reset link.'
    end
  end

  def set_password
    if user = User.find(params[:id]).authenticate(params[:reset_password_token])
      user.update(password: params[:password])
      redirect_to login_path, notice: 'Password reset. Please log in.'
    else
      redirect_to reset_password_path, notice: 'Unable to reset password.'
    end
  end

  private

  def login_user(user)
    reset_session
    session[:user_id] = user.id
  end

  def remember_user(user)
    cookies.encrypted[:user_id] = user.id
  end


end
