class TreeTestReportsController < ReportsController
  private

  def set_study
    @study = TreeTest.find_by(report_token: params[:id])
  end

  def set_session_id
    @session_id = "tt_#{params[:id]}"
  end

  def set_paths
    @login_path = login_tree_test_report_path(params[:id])
    @report_path = tree_test_report_path(params[:id])
  end   
end

