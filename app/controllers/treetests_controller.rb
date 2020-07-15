class TreetestsController < ApplicationController

  layout 'dashboard'

  def render_static
    render "#{params[:path]}"
  end

end