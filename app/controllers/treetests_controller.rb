class TreetestsController < ApplicationController
    def show
        render template: "treetests/#{params[:page]}"
    end
    layout 'dashboard'
  end  