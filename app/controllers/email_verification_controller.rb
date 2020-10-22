class EmailVerificationController < UnauthenticatedController
  skip_before_action :check_for_login
  
  def verify
    email_verification = EmailVerification.find_by(token: params[:token])
    user = email_verification.user
    if email_verification.created_at > 1.day.ago
      user.update(verified: true)
      email_verification.destroy
      EmailVerificationChannel.broadcast_to(user, path: dashboard_url)
      redirect_to root_path, notice: 'Email verified.'
    else 
    end
  end
end
