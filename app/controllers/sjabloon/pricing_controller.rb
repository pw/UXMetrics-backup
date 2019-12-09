class Sjabloon::PricingController < ApplicationController

  layout "dashboard"

  def show
    @plans = Sjabloon::Plan.
      active.
      visible.
      monthly.
      order(position: :asc, amount: :asc)
  end

  def expired
    @plans = Sjabloon::Plan.
      active.
      visible.
      monthly.
      order(position: :asc, amount: :asc)
  end

end
