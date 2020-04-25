class TreeTestsController < ApplicationController
  before_action :authenticate_user!

  layout 'dashboard'

  def new 
  end

  def create
    @tree_test = current_user.tree_tests.new(tree_test_params)
    if @tree_test.save
      redirect_to edit_tree_test_path(@tree_test)
    else
    end  

  end

  def index
    @tree_tests = current_user.tree_tests.all
  end

  def edit
    @tree_test = current_user.tree_tests.where(id: params[:id]).includes(tree_test_tasks: :tree_test_task_correct_choices)
  end

  def update
    current_user.tree_tests.update(params[:id], tree_test_params)
    head :ok
  end

  def destroy
    current_user.tree_tests.find(params[:id]).destroy
    redirect_to tree_tests_path
  end

  def report
    @tree_test = current_user.tree_tests.where(id: params[:id]).includes(tree_test_tasks: :tree_test_task_correct_choices)
  end

  def participants
    if (params[:task] != 'all') && (params[:result] != 'all')
      join_array = ["INNER JOIN tree_test_participant_results ON tree_test_participant_results.tree_test_participant_id = tree_test_participants.id AND tree_test_participant_results.tree_test_task_id = ? AND tree_test_participant_results.outcome = ?", params[:task], params[:result]]
      render json: {
        participants: current_user.tree_tests.find(params[:id]).tree_test_participants.order(:participant_id).limit(1).offset(params[:offset]).joins(TreeTest.sanitize_sql_array(join_array)), 
          total: current_user.tree_tests.find(params[:id]).tree_test_participants.joins(TreeTest.sanitize_sql_array(join_array)).count
      }
    else
      render json: {participants: current_user.tree_tests.find(params[:id]).tree_test_participants.order(:participant_id).limit(1).offset(params[:offset]), total: current_user.tree_tests.find(params[:id]).tree_test_participants.count}
    end
  end

  private 

  def tree_test_params
    params.require(:tree_test).permit(:name, :participant_instructions, :thank_you_message, :randomize_tree_order, :tree, :current_tree_index, :randomize_task_order, :allow_skip, :status, tree_test_tasks_attributes: [:instructions, :task_number, :id, :_destroy, tree_test_task_correct_choices_attributes: [:node, :path]])
  end
end  