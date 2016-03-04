class OutdoorAlertsController < ApplicationController
  def new
    @outdoor_alert = OutdoorAlert.new
    @phone = Phone.new
    @location = Location.new
  end

  def create
    @location, @phone, @outdoor_alert = OutdoorAlertCreator.make(location_params,
                                                                 phone_params,
                                                                 outdoor_alert_params,
                                                                 current_user)
    if @location.save & @phone.save & @outdoor_alert.save
      @outdoor_alert.initial_alert
      flash[:success] = "Outdoor Air Alert created!"
      redirect_to alerts_path
    else
      render :new
    end
  end

  def destroy
    @outdoor_alert = OutdoorAlert.find(params[:id])
    @location = @outdoor_alert.location
    @phone = @outdoor_alert.phone
    @outdoor_alert.delete
    @location.delete if @location.outdoor_alerts.empty?
    @phone.delete if @phone.outdoor_alerts.empty?

    redirect_to alerts_path
  end

  private

  def outdoor_alert_params
    params.require(:outdoor_alert).permit(:reason, :poor, :low, :moderate, :fair,
                                          :excellent)
  end

  def phone_params
    params.require(:phone).permit(:number)
  end

  def location_params
    params.require(:location).permit(:address)
  end
end
