class CardSortGroupsController < ApplicationController
  before_action :authenticate_user!, except: :create_participant_designated_group

  def create
    if CardSort.find(params[:card_sort_group][:card_sort_id]).user == current_user
      render json: CardSortGroup.create(card_sort_group_params)
    else
      head :forbidden
    end
  end

  def create_participant_designated_group
    if existing_group = CardSort.find(params[:card_sort_group][:card_sort_id]).card_sort_groups.find_by(name: params[:card_sort_group][:name].titlecase)
      render json: existing_group
    else
      render json: CardSortGroup.create(card_sort_group_params)
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