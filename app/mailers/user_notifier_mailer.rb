class UserNotifierMailer < ApplicationMailer
  default :from => 'Userdrive <zsolt@userdrive.co>'

  layout 'mailer'
  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)

    @user = user

    mail( :to => @user.email,
    :subject => 'Thanks for trying Userdrive' )
  end

  def send_first_cardtest_email(user, cardtest)

    @user = user
    @cardtest = cardtest

    mail( :to => @user.email,
    :subject => 'Congrats on creating your first cardtest!' )
  end

  def send_first_result_email(user, cardtest)

    @user = user
    @cardtest = cardtest

    mail( :to => @user.email,
    :subject => "Your cardtest just had it's first response!" )
  end



end
