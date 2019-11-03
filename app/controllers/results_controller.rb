class ResultsController < ApplicationController
  before_action :set_result, only: [:index, :show, :edit, :update, :destroy, :download]
  before_action :set_cardtest, except: [:new]

  require "csv"

  layout "dashboard"
  # GET /results

  def download

    @cardtest = Cardtest.find_by(uid: params[:cardtest_uid])
    @results = Result.where(cardtest_id: @cardtest.id)


    # @csv_string = CSV.generate do |csv|
    #   csv << ["test name", "response id", "groups", "cards", "created at", "time to complete"]
    #
      # @resultgroups = []
    #   @resultdata = []
      # @results.each do |resultGroup|
      #   @resultgroups.push(JSON.parse(resultGroup.data)['groups'])
      #   @resultdata.push([resultGroup.id, resultGroup.created_at, JSON.parse(resultGroup.data)['time']])
      # end
    #   @resultgroups.each_with_index do |groups,index|
    #     g = groups.map{|e| {e.keys[0] => e.values[0].capitalize, e.keys[1] => e.values[1]}}
    #     g.each do |group|
    #       group['card'].map! {|id| Card.find(id).name}
    #       csv << [@cardtest.name, @resultdata[index][0], group['title'], group['card'], @resultdata[index][1], get_duration_hrs_and_mins(@resultdata[index][2])]
    #     end
    #   end
    # end

    @csv_string = CSV.generate do |csv|
      csv << ["participant", "response id", "cards", "groups", "created at", "time to complete"]

      @resultgroups = []
      @resultdata = []

      @results.each do |resultGroup|
        @resultgroups.push(JSON.parse(resultGroup.data)['groups'])
        @resultdata.push([resultGroup.id, resultGroup.created_at, JSON.parse(resultGroup.data)['time']])
      end



      @cardsByGroups = []

      @cardtest.cards.sort_by(&:order).each do |card|
        @cardsByGroups.push({"id":card.id,"name":card.name,"titles":get_group_titles_for_card(card.id)}.to_json)
      end

      @cardsByGroups.each_with_index do |cardIdRow, index|
        csv << [index+1, @resultdata[index][0], JSON.parse(cardIdRow)["name"], JSON.parse(cardIdRow)["titles"].join(", "), @resultdata[index][1], get_duration_hrs_and_mins(@resultdata[index][2])]
      end

    end

    puts @csv_string

    send_data @csv_string, filename: "#{@cardtest.name.to_s}-results.csv"
  end

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

    @titleslist = []

    @resultgroups.each do |groups|

          #determine groups per result
          groupCount = 0
          # p "groups below::::"





          # p "*****************map below:***********************"

          g = groups.map{|e| {e.keys[0] => e.values[0].capitalize, e.keys[1] => e.values[1]}}

          # p g

          g.each do |group|




            # p group
            # p JSON.parse(group)
            # p "how about this ------"
            # p group

            if group['card'].length > 0

              contains = []

              # group['title'] = group['title'].capitalize

              # need to get unique capitalized titles grouped, except Unnamed
              # with all the cards grouped under it
              if group['title'] == "Unnamed"
                @titleslist.push({"title":group['title'],"cards":group['card'], "createdby":1})
              else
                # puts "else"
                # puts "looking for "+group['title']+ " in: "
                # p @titleslist


                createdby = 1


                contains = @titleslist.detect{|g| g[:title] == group['title']}

                if !contains.nil?
                  # puts "-------------------- CONTAINS -------------------"
                  createdby = createdby+1
                  i = @titleslist.index(contains)

                  # p @titleslist[i]

                  cardsToMerge = @titleslist[i].slice(:cards)
                  cardsToMergeTitles = @titleslist[i].slice(:title)

                  # p "before merge"
                  # p cardsToMerge

                  # p @titleslist[i]

                  cardsToMerge.merge!({:cards => group['card'], :createdby => createdby}){|key, oldval, newval| oldval+newval}
                  # cardsToMerge[:cards].uniq!

                  # p "after merge"
                  # p cardsToMerge

                  @titleslist[i] = cardsToMergeTitles.merge(cardsToMerge)
                  # @titleslist[i][:cards].merge!(group['card']}){|key, oldval, newval| oldval+newval}

                else
                  # puts "-------------------- DOESN'T CONTAIN ------------"
                  @titleslist.push({"title":group['title'],"cards":group['card'], "createdby":createdby})
                end

                # if @titleslist.includes?(group['title'])
                  # @titleslist.merge({"title":group['title'],"cards":group['card']}){|key, oldval, newval| oldval+newval}
                # else

                # end

              end





              groupCount += 1
            end

          end





          # testtt = [{},{"title":"Name1", "cards":["8"]}]
          # p testtt.class
          # testttc = testtt.detect{|g| g[:title] == "Name1"}

          # puts "€€€€€€€€€€€€€€ A QUICK TEST €€€€€€€€€€€: "+testttc.to_s


          @groupsperresult.push(groupCount)
    end

    @titleslist.each do |title|
      title[:cards] = title[:cards].group_by{|i| i}.map{|k,v| [k, v.count] }
    end

    @mediangroups = median(@groupsperresult)

    @cardsByGroups = []

    @cardtest.cards.sort_by(&:order).each do |card|
      @cardsByGroups.push({"id":card.id,"name":card.name,"titles":get_group_titles_for_card(card.id)}.to_json)
    end



    agreementScores = []
    sortedPercent = []

    @cardsByGroups.each_with_index do |cardIdRow, index|
      countArrayAgreement = []
      countArray = []
      titlesGrouped = JSON.parse(cardIdRow)['titles'].group_by{|i| i}.map{|k,v| [k, v.count] }
      # puts "TEST"
      # puts titlesGrouped
      titlesGrouped.sort_by{|k|k[1]}.reverse.each do |element|
        countArray.push(element[1])
        if element[0] != "Unnamed"
          countArrayAgreement.push(element[1])
        end
      end
      # puts countArray
      if countArrayAgreement.max == 1 or countArrayAgreement.count == 0
        agreementScores.push(0)
      else
        agreementScores.push(((countArrayAgreement.max.to_f/countArray.sum.to_f) * 100).round(1))
      end

      sortedPercent.push(((countArray.sum.to_f/@results.count.to_f) * 100).round(1))

      # JSON.parse(cardIdRow)[:agreementScores] = agreementScores
      # puts cardIdRow

    end

    @cardsByGroups.map!.with_index {|item, index| item.insert(-2, ',"sortedpercent":'+sortedPercent[index].to_s+',"agreementscore":'+agreementScores[index].to_s)}
    # test = @cardsByGroups[0]
    # # test.merge!("fszf": "sad")
    # # test.to_json
    #
    # # test.insert(-2, ',"newattr":100')
    #
    # puts test
    # puts "test"




    # get_agreement_scores_for_card



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
    @cardtest = Cardtest.find_by(auth_token: params[:auth_token])
    # @cardtest = Cardtest.find_by(uid: params[:cardtest_uid]) <-- this was wrong? now all fine :)
    render layout: "collect"
  end

  def create

    # @cardtest = Cardtest.find_by(uid: params[:cardtest_uid])
    @cardtest = Cardtest.find_by(auth_token: params[:auth_token])
    @result = @cardtest.results.new(result_params)
    @user = User.find(@cardtest.user_id)

    if @result.save

      @results = Result.where(cardtest_id: @cardtest.id)
      # @cardtests = current_user.cardtests.all
      puts "RESULT COUNT FOR THIS CARDTEST IS::::"
      puts @results.count

      if @results.count == 1
        UserNotifierMailer.send_first_result_email(@user, @cardtest).deliver_later
      end


      # redirect_to controller: :results, action: "thanks", notice: 'Result was successfully created.'
      puts @cardtest.auth_token
      puts "below:"
      puts request.query_parameters
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

    def restrict_access
      redirect_to root_path, :alert => "Access denied"
    end

    def set_result
      # @result = Result.find(params[:id])

      @cardtest = Cardtest.find_by(uid: params[:cardtest_uid])
      restrict_access if @cardtest.user_id != current_user.id


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
                @cardGroupTitles.push(group['title'].capitalize);
              end
            end
      end

      return @cardGroupTitles

    end

    def get_cards_for_group(group)
      puts "GET CARDS FOR GROUP CALLED"
      # puts cardId
      @cardGroupTitles = []
      @resultgroups.each do |groups|

            groups.each do |group|
              #puts group['card']
              #puts group['card'].include?(cardId.to_s)
              if group['card'].length > 0 && group['card'].include?(cardId.to_s)

                # puts "TRUE"
                @cardGroupTitles.push(group['title'].capitalize);
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
