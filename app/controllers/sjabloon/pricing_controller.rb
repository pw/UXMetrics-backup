class Sjabloon::PricingController < ApplicationController




  def show

    @plans = Sjabloon::Plan.
      active.
      visible.
      monthly.
      order(position: :asc, amount: :asc)

    render layout: "dashboard"
  end

  def showfront
    @plans = Sjabloon::Plan.
      active.
      visible.
      monthly.
      order(position: :asc, amount: :asc)


    render layout: false
  end

  def expired
    @plans = Sjabloon::Plan.
      active.
      visible.
      monthly.
      order(position: :asc, amount: :asc)

      render layout: "dashboard"
  end

end
