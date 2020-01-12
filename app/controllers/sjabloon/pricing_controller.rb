class Sjabloon::PricingController < ApplicationController




  def show

    @plans = Sjabloon::Plan.
      active.
      visible.
      order(position: :desc, amount: :desc)

    render layout: "dashboard"
  end

  def showfront
    @plans = Sjabloon::Plan.
      active.
      visible.
      order(position: :desc, amount: :desc)


    render layout: false
  end

  def expired
    @plans = Sjabloon::Plan.
      active.
      visible.
      order(position: :desc, amount: :desc)

      render layout: "dashboard"
  end

end
