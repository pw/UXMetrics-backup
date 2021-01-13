class TreeTestTasksController < ApplicationController
  skip_before_action :authenticate, only: :outcome
  skip_before_action :check_verification, only: :outcome

  def create
    return head :forbidden unless TreeTest.find(params[:tree_test_task][:tree_test_id]).user == current_user

    @tree_test_task = TreeTestTask.new(tree_test_task_params)
    if @tree_test_task.save
      render json: TreeTestTask.includes(:tree_test_task_correct_choices).find(@tree_test_task.id).to_json(include: :tree_test_task_correct_choices)
    else
      head :internal_server_error
    end
  end

  def destroy
    @tree_test_task = TreeTestTask.find(params[:id])

    return head :forbidden unless @tree_test_task.tree_test.user == current_user

    if result = @tree_test_task.destroy 
      render json: result
    else 
      head :internal_server_error
    end   
  end

  def update
    @tree_test_task = TreeTestTask.find(params[:id])

    return head :forbidden unless @tree_test_task.tree_test.user == current_user

    @tree_test_task.tree_test_task_correct_choices.destroy_all if params[:tree_test_task][:tree_test_task_correct_choices_attributes]
    if @tree_test_task.update(tree_test_task_params)
      render json: @tree_test_task
    else 
      render head :internal_server_error
    end
  end
    
  def outcome
    tree_test_task = TreeTestTask.find(params[:id])

    case params[:outcome]
    when "indirect_correct"
      render json: tree_test_task.results_summary_indirect_correct
    when "direct_incorrect"
      render json: tree_test_task.results_summary_direct_incorrect
    when "indirect_incorrect"
      render json: tree_test_task.results_summary_indirect_incorrect
    when "indirect_skip"
      render json: tree_test_task.results_summary_skipped_indirect
    end
    
  end

  private

  def tree_test_task_params
    params.require(:tree_test_task).permit(
      :id, :order, :instructions, 
      :tree_test_id, tree_test_task_correct_choices_attributes: [:node, :path])
  end

end