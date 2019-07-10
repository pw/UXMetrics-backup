class CardtestsController < ApplicationController
  before_action :set_cardtest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :force_subscribe


  layout 'dashboard'



  # GET /cardtests
  def index
    @cardtests = current_user.cardtests.all
  end

  # GET /cardtests/1
  def show
    #@cardtest = Cardtest.find_by(slug: params[:slug])
    #@cardtest = Cardtest.find_by(slug: params[:id])


  end

  # GET /cardtests/new
  def new
    @cardtest = Cardtest.new
    @cardtest.cards.new
    @cardtest.status = false
  end

  # GET /cardtests/1/edit
  def edit
    #@cardtest = Cardtest.find_by(slug: params[:id])
    # puts @cardtest.uid
    # @cardtest = Cardtest.find_by(uid: params[:uid])
    # puts @cardtest.uid
  end

  # POST /cardtests
  def create
    @cardtest = current_user.cardtests.new(cardtest_params)
    @cardtest.status = ActiveModel::Type::Boolean.new.cast(@cardtest.status)
    # name = @cardtest.name
    # puts name
    # slug = to_slug(name)
    #
    # @cardtest.slug = to_slug(name)




    if @cardtest.save
      redirect_to @cardtest, notice: 'Cardtest was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cardtests/1
  def update
    #@cardtest = Cardtest.find_by(slug: params[:id])
    @cardtest = Cardtest.find_by(uid: params[:uid])
    @cardtest.status = ActiveModel::Type::Boolean.new.cast(@cardtest.status)
    if @cardtest.update(cardtest_params)
      # redirect_to cardtests_url, notice: 'Cardtest was successfully updated.'
      redirect_to edit_cardtest_url, notice: 'Cardtest was successfully updates.'
      # render :edit
    else
      puts "update else"
      render :edit
    end
  end

  # DELETE /cardtests/1
  def destroy
    #@cardtest = Cardtest.find_by(slug: params[:id])

    @cardtest.cards.destroy_all
    @cardtest.results.destroy_all
    @cardtest.destroy
    redirect_to cardtests_url, notice: 'Cardtest was successfully destroyed.'
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cardtest

      @cardtest = Cardtest.find_by(uid: params[:uid])
      # @cardtest = Cardtest.find_by(slug: params[:slug])
      # @cardtest = Cardtest.find_by(slug: params[:slug])
    end

    # Only allow a trusted parameter "white list" through.
    def cardtest_params

      params.require(:cardtest).permit(:name, :items, :user, :status, :uid, cards_attributes: [:id, :name, :order, :_destroy])

    end

    def force_subscribe
      puts "force called"
      if current_user.subscribed? == false
        puts "subscribed false"
        redirect_to pricing_path
      end
    end






end
