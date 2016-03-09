class LegislationController < ApplicationController
  def show
    if params[:state]
      @bills = Legislation.bills(params[:state])
    end
  end
end
