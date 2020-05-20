class CardSortGroupsController < ApplicationController
  before_action :authenticate_user!

  def create
    if CardSort.find(params[:card_sort_group][:card_sort_id]).user == current_user
      render json: CardSortGroup.create(card_sort_group_params)
    else
      head :forbidden
    end
  end

  def destroy
    group = CardSortGroup.find(params[:id])

    if group.card_sort.user == current_user
      render json: group.destroy
    else
      head :forbidden
    end
  end  

  def update
    group = CardSortGroup.find(params[:id])

    if group.card_sort.user == current_user
      render json: group.update(card_sort_group_params)
    else
      head :forbidden
    end
  end

  def destroy
    if CardSort.find(params[:card_sort_group][:card_sort_id]).user == current_user
      group = Card
      render json: CardSortGroup.find(params[:id]).destroy
    else
      head :forbidden
    end
  end

  private

  def card_sort_group_params
    params.require(:card_sort_group).permit(:name, :order, :card_sort_id)
  end
end