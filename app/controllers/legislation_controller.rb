class LegislationController < ApplicationController
  before_action :authorize!
  
  def show
    if params[:state]
      @bills = Legislation.bills(params[:state])
    end
  end
end
