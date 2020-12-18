class AddDefaultsToTreeTests < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tree_tests, :name, ''
    change_column_default :tree_tests, :participant_instructions, "Thank you for agreeing to help us! This shouldn't take more than 5 minutes.\n\nThere are no right or wrong answers. Just do what makes sense to you."
    change_column_default :tree_tests, :thank_you_message, "Thanks for taking the time to help us!\n\nYour feedback is essential for us to deliver ongoing improvements."
    change_column_default :tree_tests, :randomize_tree_order, false
    change_column_default :tree_tests, :randomize_task_order, false
    change_column_default :tree_tests, :allow_skip, false
  end
end
