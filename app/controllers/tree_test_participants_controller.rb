class TreeTestParticipantsController < ApplicationController
  layout 'participants_new'

  def new
    @tree_test = TreeTest.find_by(auth_token: params[:auth_token])
  end

  def create
    @tree_test_participant = TreeTestParticipant.new(tree_test_participant_params)
    if @tree_test_participant.save
      head :ok
    else 
      head :internal_server_error
    end
  end

  def update
    @tree_test_participant = TreeTestParticipant.find(params[:id])

    head :forbidden and return if @tree_test_participant.tree_test.user != current_user

    if @tree_test_participant.update(tree_test_participant_params)
      head :ok
    else
      head :internal_server_error
    end    
  end

  def destroy
    @tree_test_participant = TreeTestParticipant.find(params[:id])

    head :forbidden and return if @tree_test_participant.tree_test.user != current_user

    if @tree_test_participant.destroy
      head :ok
    else
      head :internal_server_error
    end
  end

  private
    def tree_test_participant_params
      params.require(:tree_test_participant).permit(:tree_test_id,  
        :excluded,
        tree_test_participant_results_attributes: [:tree_test_task_id, :time, :choice, :skip, :path, :direct])
    end
end