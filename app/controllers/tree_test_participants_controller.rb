class TreeTestParticipantsController < ApplicationController
  layout 'participants_new'

  def new
    @tree_test = TreeTest.find_by(auth_token: params[:auth_token])
  end
end