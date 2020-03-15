class TreetestParticipantsController < ApplicationController
    def show
        render template: "treetest_participants/#{params[:page]}"
    end
    layout 'participants'
  end  