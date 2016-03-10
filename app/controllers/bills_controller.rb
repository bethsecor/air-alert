class BillsController < ApplicationController
  before_action :authorize!

  def show
    @bill = Bill.bill(params[:bill_id])
  end
end
