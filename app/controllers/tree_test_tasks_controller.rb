class TreeTestTasksController < ApplicationController
  def create
    tree_test = TreeTest.find(params[:tree_test_task][:tree_test_id])
    tree_test_task = TreeTestTask.new
    if tree_test.user == current_user
      tree_test_task.tree_test = tree_test
      if tree_test_task.save
        render json: TreeTestTask.includes(:tree_test_task_correct_choices).find(tree_test_task.id).to_json(include: :tree_test_task_correct_choices)
      else
        head :internal_server_error
      end
    else
      head :forbidden
    end
  end

  def update
    tree_test_task = TreeTestTask.find(params[:id])

    if tree_test_task.tree_test.user == current_user
      tree_test_task.tree_test_task_correct_choices.destroy_all
      tree_test_task.update(tree_test_task_params)
    else
      head :forbidden
    end
  end
    
  def outcome
    tree_test_task = TreeTestTask.find(params[:id])

    head :forbidden and return unless tree_test_task.tree_test.user == current_user

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
    params.require(:tree_test_task).permit(:tree_test_id, tree_test_task_correct_choices_attributes: [:node, :path])
  end

end