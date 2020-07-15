class CardsortParticipantsController < ApplicationController
    def show
        render template: "cardsort_participants/#{params[:page]}"
    end
    layout 'participants'
  end  