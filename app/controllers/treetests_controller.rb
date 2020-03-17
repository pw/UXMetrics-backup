class TreetestsController < ApplicationController
  layout 'dashboard'

  def new 
  end


  def page2
    render 'treetests/new-tree'
  end
end  