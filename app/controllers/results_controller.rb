class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]
  before_action :set_cardtest, except: [:new]



  layout "dashboard"
  # GET /results
  def index


    @cardtest = Cardtest.find_by(uid: params[:cardtest_uid])

    # puts params[:uid]
    # puts "CARDTEST ID"
    # puts @cardtest.id

    @results = Result.where(cardtest_id: @cardtest.id)

    #resultData = Result.select(:id, "data -> 'groups' as groups").map(&:groups)
    #puts resultData

    @resultnames = []
    @resultgroups = []
    @resulttimes = []

    @results.each do |resultGroup|

      #puts resultGroup.data.to_json.class
      #puts resultGroup.data.to_json
      #puts resultGroup.data["name"]

      #puts Oj.dump(resultGroup.data)
      begin
        # puts JSON.parse(resultGroup.data)
        @resultnames.push(JSON.parse(resultGroup.data)['name'])
        @resultgroups.push(JSON.parse(resultGroup.data)['groups'])
        @resulttimes.push(JSON.parse(resultGroup.data)['time'])
      rescue => e
        puts "errors ofc"
      end

    end


    @mediantime = get_duration_hrs_and_mins(median(@resulttimes))

    @mediangroups = 0

    @groupsperresult = []

    @resultgroups.each do |groups|
          groupCount = 0
          groups.each do |group|
            if group['card'].length > 0
              groupCount += 1
            end
          end
          @groupsperresult.push(groupCount)
    end

    @mediangroups = median(@groupsperresult)

    @cardsByGroups = []

    @cardtest.cards.sort_by(&:order).each do |card|
      @cardsByGroups.push({"id":card.id,"name":card.name,"titles":get_group_titles_for_card(card.id)}.to_json)
    end

    get_agreement_scores_for_card



  end

  # GET /results/1
  def show
  end

  # GET /results/new
  def new
    @cardtest = Cardtest.find_by(auth_token: params[:auth_token])
    @result = Result.new
    render layout: "collect"

  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  def thanks
    @cardtest = Cardtest.find_by(uid: params[:cardtest_uid])
    render layout: "collect"
  end

  def create

    # @cardtest = Cardtest.find_by(uid: params[:cardtest_uid])
    @cardtest = Cardtest.find_by(auth_token: params[:auth_token])
    @result = @cardtest.results.new(result_params)

    if @result.save
      # redirect_to controller: :results, action: "thanks", notice: 'Result was successfully created.'
      puts @cardtest.auth_token
       redirect_to thanks_url, auth_token: @cardtest.auth_token, status: 301
       # redirect_to thanks_url, auth_token: "1", status: 301
       # redirect_to thanks_url, :auth_token => @cardtest.auth_token, status: 301

    else
      render :new
    end
  end

  # PATCH/PUT /results/1
  def update
    if @result.update(result_params)
      redirect_to @result, notice: 'Result was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /results/1
  def destroy
    @result.destroy
    redirect_to results_url, notice: 'Result was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def result_params
      params.require(:result).permit(:name, :data, :cardtest_id)
    end

    protected

    def set_cardtest
      @cardtest = Cardtest.find_by(uid: params[:uid])
      # @cardtest = Cardtest.friendly.find(params[:auth_token]) - doesn't work
    end

    def median(array)

      array.reject! { |item| item.blank? }

      sorted = array.sort
      len = sorted.length

      begin
        return (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
      rescue => e
        puts "errors in array ofc"
      end
    end


    def get_duration_hrs_and_mins(milliseconds)
      return '' unless milliseconds

      hours, milliseconds   = milliseconds.divmod(1000 * 60 * 60)
      minutes, milliseconds = milliseconds.divmod(1000 * 60)
      seconds, milliseconds = milliseconds.divmod(1000)
      if hours == 0 and minutes !=0
        "#{minutes}m #{seconds}s"
      elsif hours == 0 and minutes == 0
        "#{seconds}s"
      else
        "#{hours}h #{minutes}m #{seconds}s"
      end
    end


    def get_group_titles_for_card(cardId)
      puts "GET GROUP TITLES FOR CARD CALLED"
      # puts cardId
      @cardGroupTitles = []
      @resultgroups.each do |groups|

            groups.each do |group|
              #puts group['card']
              #puts group['card'].include?(cardId.to_s)
              if group['card'].length > 0 && group['card'].include?(cardId.to_s)

                # puts "TRUE"
                @cardGroupTitles.push(group['title']);
              end
            end
      end

      return @cardGroupTitles

    end


    def get_agreement_scores_for_card()

      @cardsByGroups.each do |test|
        puts test
      end


    end



end
