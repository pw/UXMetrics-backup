class CardSortParticipantsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create, :show]
  skip_before_action :check_verification, only: [:new, :create, :show]
  layout 'participants'

  def new
    @card_sort = CardSort.find_by(auth_token: params[:auth_token])

    redirect_to :not_found if @card_sort.status != 'published' && !params[:preview]
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
    respond_to do |format|
      format.html {
        render 
      }
      format.json {
        render json: @card_sort_participant
      }
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
        :sort,
        :recording,
        card_sort_sorts_attributes: [:card_sort_id, :card_sort_group_id, :card_sort_card_id])
    end
end