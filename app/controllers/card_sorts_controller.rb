class CardSortsController < ApplicationController
  before_action :authenticate_user!

  layout 'dashboard'

  def new
  end

  def create
    @card_sort = current_user.card_sorts.new(card_sort_params)

    if @card_sort.save
      redirect_to edit_card_sort_path(@card_sort)
    else
      head :internal_server_error
    end
  end

  def show
    @card_sort = CardSort.find(params[:id])

    if @card_sort.user == current_user
      render json: @card_sort.to_json(methods: [:card_results, :group_results, :participants])
    else
      head :forbidden
    end   
  end

  def index
    @card_sorts = current_user.card_sorts.all
  end

  def edit
    @card_sort = current_user.card_sorts.where(id: params[:id]).includes(:card_sort_groups, :card_sort_cards)
  end

  def update
    result = current_user.card_sorts.update(params[:id], card_sort_params)
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
    params.require(:card_sort).permit(:name, :logo_key, :participant_instructions, :thank_you_message, :sort_type, :status, :randomize_card_order, card_sort_groups_attributes: [:name, :order, :id, :_destroy], card_sort_cards_attributes: [:title, :description, :has_description, :order, :id])
  end
end