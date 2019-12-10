class PagesController < ApplicationController

  def pricing
    @plans = Sjabloon::Plan.
      active.
      visible.
      monthly.
      order(position: :asc, amount: :asc)
  end

end
