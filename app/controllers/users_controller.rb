class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  layout "dashboard"

  def authenticate_admin!
    # check if current user is admin
    unless current_user.admin
      # if current_user is not admin redirect to some route
      redirect_to '/cardtests'
    end
    # if current_user is admin he will proceed to edit action
  end

  def index
    @users = User.all
  end
end
