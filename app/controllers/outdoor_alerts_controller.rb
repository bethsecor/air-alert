class OutdoorAlertsController < ApplicationController
  def new
    @outdoor_alert = OutdoorAlert.new
  end

  def create
    @outdoor_alert = OutdoorAlert.new(outdoor_alert_params.except(:location, :phone))
    @outdoor_alert.user = current_user
    @outdoor_alert.location = Location.find_or_create_by(address: outdoor_alert_params[:location])
    @outdoor_alert.phone = Phone.find_or_create_by(number: outdoor_alert_params[:phone])

    if @outdoor_alert.save
      flash[:success] = "Outdoor Air Alert created for #{@outdoor_alert.location}."
      redirect_to alerts_path
    else
      render :new
    end
  end

  private

  def outdoor_alert_params
    params.require(:outdoor_alert).permit(:location, :phone, :reason,
                                          :poor, :low, :moderate, :fair,
                                          :excellent)
  end
end
