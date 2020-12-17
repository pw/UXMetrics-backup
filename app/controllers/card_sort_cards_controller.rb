class CardSortCardsController < ApplicationController
  def create
    @card_sort_card = current_user.card_sorts.find(params[:card_sort_card][:card_sort_id]).card_sort_cards.new(card_sort_card_params)
    if @card_sort_card.save
      render json: @card_sort_card
    else
      head :internal_server_error
    end
  end

  def destroy
    @card = CardSortCard.find(params[:id])

    return head :forbidden unless @card.user == current_user

    if @card.destroy
      render json: @card
    else 
      head :internal_server_error
    end
  end

  def update
    @card = CardSortCard.find(params[:id])

    return head :forbidden unless @card.user == current_user

    if @card.update(card_sort_card_params)
      render json: @card
    else 
      head :internal_server_error
    end
  end

  private

  def card_sort_card_params
    params.require(:card_sort_card).permit(:id, :title, :description, :has_description, :order, :card_sort_id)
  end
end