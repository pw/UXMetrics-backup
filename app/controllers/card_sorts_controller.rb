class CardSortsController < ApplicationController
  layout 'dashboard'

  def new
    @card_sort = current_user.card_sorts.new
  end

  def create
    @card_sort = current_user.card_sorts.new(card_sort_params)

    if @card_sort.save
      render json: @card_sort
    else
      head :internal_server_error
    end
  end

  def index
    @card_sorts = current_user.card_sorts.all.order(updated_at: :desc)
  end

  def edit
    @card_sort = current_user.card_sorts.where(id: params[:id]).includes(:card_sort_groups, :card_sort_cards).first
    if @card_sort.creation_wizard_complete
      render
    else
      render 'new'
    end
  end

  def update
    result = current_user.card_sorts.update(params[:id], card_sort_params)
    current_user.card_sorts.find(params[:id]).card_sort_groups.destroy_all if params[:card_sort][:sort_type] == 'open'
    render json: result
  end

  def destroy
    current_user.card_sorts.find(params[:id]).destroy
    redirect_to card_sorts_path
  end

  def report
    @card_sort = current_user.card_sorts.where(id: params[:id])
  end

  private

  def card_sort_params
    params.require(:card_sort).permit(:name, :logo_key, :participant_instructions, :thank_you_message, :sort_type, :status, :randomize_card_order, :creation_step, :creation_wizard_complete, card_sort_groups_attributes: [:name, :order, :id, :_destroy], card_sort_cards_attributes: [:title, :description, :has_description, :order, :id])
  end
end