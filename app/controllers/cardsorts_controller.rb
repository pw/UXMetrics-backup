class CardsortsController < ApplicationController
    def show
        render template: "cardsorts/#{params[:page]}"
    end
    layout 'dashboard'
  end  