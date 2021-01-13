class CardSortGroupsController < ApplicationController
  skip_before_action :authenticate, only: :create_participant_designated_group
  skip_before_action :check_verification, only: :create_participant_designated_group

  def create
    return head :forbidden unless CardSort.find(params[:card_sort_group][:card_sort_id]).user == current_user

    @card_sort_group = CardSortGroup.new(card_sort_group_params)
    
    if @card_sort_group.save
      render json: @card_sort_group
    else
      head :internal_server_error
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
      groups = params[:group_ids].map{|id| CardSortGroup.find(id)}
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
    merge_group = CardSortGroup.find(params[:id])
    if merge_group.card_sort.user === current_user
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
    merge_group = CardSortGroup.find(params[:id])
    if merge_group.card_sort.user === current_user
      groups_to_remove = (merge_group.merged_groups.map{|i| i.id}.to_set - params[:group_ids].map{|i| i.to_i}.to_set).map{|i| CardSortGroup.find(i)}
      groups_to_remove.each do |group|
        CardSortSort.where(pre_merge_group_id: group.id).update_all(card_sort_group_id: group.id, pre_merge_group_id: nil)
        group.merged_group_id = nil
        group.save
      end
      merge_group.name = params[:name]
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

  private

  def card_sort_group_params
    params.require(:card_sort_group).permit(:name, :order, :card_sort_id)
  end
end