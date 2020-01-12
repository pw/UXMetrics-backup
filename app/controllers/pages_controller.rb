class PagesController < ApplicationController

  def pricing
    @plans = Sjabloon::Plan.
      active.
      visible.
      order(position: :desc, amount: :desc)
  end

end
