class CardtestsController < ApplicationController
  before_action :set_cardtest, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :force_subscribe


  layout 'dashboard'



  # GET /cardtests
  def index
    @cardtests = current_user.cardtests.all

    # CardtestWorker.perform_async(current_user.email)
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

    @cardtests = current_user.cardtests.all



    @cardtest = current_user.cardtests.new(cardtest_params)
    @cardtest.status = "draft"



    if @cardtest.intro == "" or !@cardtest.intro?
      @cardtest.intro = "Thank you for agreeing to help us, it shouldn't take more than 5 minutes!

The left column contains cards that we'd like you to categorize into groups that make sense to you. You can do this by dragging them into the area on the right.

Don't worry, there is no right or wrong answer, just do what makes sense to you."
    end

    if @cardtest.outro == "" or !@cardtest.outro?
      @cardtest.outro = "Thanks for taking the time to help us.

Your contribution is essential in our journey to deliver improvements."
    end

    # name = @cardtest.name
    # puts name
    # slug = to_slug(name)
    #
    # @cardtest.slug = to_slug(name)

    @cardtest.cards.each_with_index do |card, index|
      card.order = index
    end



    if @cardtest.save
      redirect_to edit_cardtest_path(@cardtest), notice: 'Cardtest was successfully created.'

      if @cardtests.count == 1
        UserNotifierMailer.send_first_cardtest_email(current_user, @cardtest).deliver_later
      end


    else
      render :new
    end
  end

  # PATCH/PUT /cardtests/1
  def update
    #@cardtest = Cardtest.find_by(slug: params[:id])
    @cardtest = Cardtest.find_by(uid: params[:uid])
    # @cardtest.status = ActiveModel::Type::Boolean.new.cast(@cardtest.status)

    @cardtest.cards.each_with_index do |card, index|
      card.order = index
      puts card.order
    end


    if @cardtest.update(cardtest_params)
      # redirect_to cardtests_url, notice: 'Cardtest was successfully updated.'

      redirect_to edit_cardtest_url, notice: 'Cardtest was successfully updated.'
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

  def delete_image_attachment

    puts "is this even?"
    @cardtest_img = ActiveStorage::Attachment.find(params[:uid])
    @cardtest_img.purge
    redirect_back(fallback_location: request.referer)
  end




  private
    # Use callbacks to share common setup or constraints between actions.

    def restrict_access
      redirect_to root_path, :alert => "Access denied"
    end

    def set_cardtest

      @cardtest = Cardtest.find_by(uid: params[:uid])
      restrict_access if @cardtest.user_id != current_user.id && !current_user.admin
      # @cardtest = Cardtest.find_by(slug: params[:slug])
      # @cardtest = Cardtest.find_by(slug: params[:slug])
    end

    # Only allow a trusted parameter "white list" through.
    def cardtest_params

      params.require(:cardtest).permit(:name, :items, :user, :status, :uid, :logoimg, :intro, :outro, :random, :testtype, :fixedgroups, cards_attributes: [:id, :name, :order, :_destroy])

    end

    def force_subscribe
      puts "force called"

      # the below thing is forcing people to subscript to a paid plan
      # if current_user.subscribed? == false
      #   puts "subscribed false"
      #   redirect_to pricing_path
      # end

      puts current_user.created_at

      # if account was created less than 60 days ago it's in "triel" - not stripe trial though
      if current_user.created_at < 60.days.ago
        if current_user.subscribed? == false
          puts "subscribed false"
          redirect_to pricing_path
        end
      end


    end








end
