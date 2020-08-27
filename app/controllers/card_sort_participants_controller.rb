class CardSortParticipantsController < ApplicationController
  layout 'participants_new'

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
    if CardSort.find(params[:card_sort_id]).user == current_user
      render json: CardSortParticipant.find(params[:id])
    else
      head :forbidden
    end    
  end

  def update
    @tree_test_participant = TreeTestParticipant.find(params[:id])

    head :forbidden and return if @tree_test_participant.tree_test.user != current_user

    if @tree_test_participant.update(tree_test_participant_params)
      head :ok
    else
      head :internal_server_error
    end    
  end

  def destroy
    @tree_test_participant = TreeTestParticipant.find(params[:id])

    head :forbidden and return if @tree_test_participant.tree_test.user != current_user

    if @tree_test_participant.destroy
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