class CardSortReportsController < ReportsController
  private
  def set_study
    @study = CardSort.find_by(report_token: params[:id])
  end

  def set_session_id
    @session_id = "cs_#{params[:id]}"
  end

  def set_paths
    @login_path = login_card_sort_report_path(params[:id])
    @report_path = card_sort_report_path(params[:id])
  end   
end

