class CardSortParticipantsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]
  skip_before_action :check_verification, only: [:new, :create]
  layout 'participants'

  def new
    @card_sort = CardSort.find_by(auth_token: params[:auth_token])
  end

  def create
    @card_sort_participant = CardSortParticipant.new(card_sort_participant_params)
    if @card_sort_participant.save
      head :ok
    else 
      head :internal_server_error
    end
  end

  def show
    @card_sort_participant = CardSortParticipant.find(params[:id])
    if @card_sort_participant.card_sort.user == current_user
      render json: @card_sort_participant
    else
      head :forbidden
    end    
  end

  def update
    @card_sort_participant = CardSortParticipant.find(params[:id])

    head :forbidden and return if @card_sort_participant.card_sort.user != current_user

    if @card_sort_participant.update(card_sort_participant_params)
      head :ok
    else 
      head :internal_server_error
    end
  end

  def destroy
    @card_sort_participant = CardSortParticipant.find(params[:id])

    head :forbidden and return if @card_sort_participant.card_sort.user != current_user

    if @card_sort_participant.destroy
      head :ok
    else
      head :internal_server_error
    end
  end

  private
    def card_sort_participant_params
      params.require(:card_sort_participant).permit(:card_sort_id,  
        :excluded,
        :time,
        card_sort_sorts_attributes: [:card_sort_id, :card_sort_group_id, :card_sort_card_id])
    end
end