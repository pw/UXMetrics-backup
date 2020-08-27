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
    if existing_group = CardSort.find(params[:card_sort_group][:card_sort_id]).card_sort_groups.find_by(name: params[:card_sort_group][:name])
      render json: existing_group
    else
      render json: CardSortGroup.create(card_sort_group_params)
    end    
  end

  def merge_groups
    if CardSort.find(params[:card_sort_id]).user == current_user
      merge_group = CardSortGroup.create(name: params[:name], card_sort_id: params[:card_sort_id])
      groups = params[:groups].map{|group| CardSortGroup.where(name: group, card_sort_id: params[:card_sort_id]).first}
      groups.each do |group|
        group.card_sort_sorts.update_all(card_sort_group_id: merge_group.id, pre_merge_group_id: group.id)
        group.merged_group_id = merge_group.id
        group.save
      end
    else
      head :forbidden
    end
  end

  def unmerge_groups
    if CardSort.find(params[:card_sort_id]).user === current_user
      merge_group = CardSortGroup.where(card_sort_id: params[:card_sort_id], name: params[:name]).first
      merge_group.merged_groups.each do |group|
        CardSortSort.where(pre_merge_group_id: group.id).update_all(card_sort_group_id: group.id, pre_merge_group_id: nil)
        group.merged_group_id = nil
        group.save
      end
      merge_group.destroy
    else
      head :forbidden
    end
  end

  def update_merged_group
    if CardSort.find(params[:card_sort_id]).user === current_user
      merge_group = CardSortGroup.where(card_sort_id: params[:card_sort_id], name: params[:name]).first
      groups_to_remove = (merge_group.merged_groups.map{|i| i.name}.to_set - params[:groups].to_set).map{|i| CardSortGroup.where(name: i, card_sort_id: params[:card_sort_id]).first}
      groups_to_remove.each do |group|
        CardSortSort.where(pre_merge_group_id: group.id).update_all(card_sort_group_id: group.id, pre_merge_group_id: nil)
        group.merged_group_id = nil
        group.save
      end
      merge_group.name = params[:updated_name]
      merge_group.save
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