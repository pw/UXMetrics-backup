class CardSortCardsController < ApplicationController
  before_action :authenticate_user!

  def create
    if CardSort.find(params[:card_sort_card][:card_sort_id]).user == current_user
      render json: CardSortCard.create(card_sort_card_params)
    else
      head :forbidden
    end
  end

  def destroy
    card = CardSortCard.find(params[:id])

    if card.card_sort.user == current_user
      render json: card.destroy
    else 
      head :forbidden
    end
  end

  def update
    card = CardSortCard.find(params[:id])

    if card.card_sort.user == current_user
      render json: card.update(card_sort_card_params)
    else 
      head :forbidden
    end
  end

  private

  def card_sort_card_params
    params.require(:card_sort_card).permit(:id, :title, :description, :has_description, :order, :card_sort_id)
  end
end