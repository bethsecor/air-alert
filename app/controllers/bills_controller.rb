class BillsController < ApplicationController
  def show
    @bill = Bill.bill(params[:bill_id])
  end
end
