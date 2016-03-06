class OutdoorAlertsController < ApplicationController
  before_action :find_outdoor_alert_objects, only: [:edit, :destroy]
  rescue_from Twilio::REST::RequestError, with: :twilio_bad_request

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
    if @location.errors.messages.empty? & @phone.errors.messages.empty? & @outdoor_alert.save
      @outdoor_alert.initial_alert
      flash[:success] = "Outdoor Air Alert created!"
      redirect_to alerts_path
    else
      render :new
    end
  end

  def update
    @location, @phone, @outdoor_alert = OutdoorAlertCreator.update(params[:id],
                                                                   location_params,
                                                                   phone_params,
                                                                   outdoor_alert_params)
    if @location.errors.messages.empty? & @phone.errors.messages.empty? & @outdoor_alert.save
      flash[:success] = "Outdoor Air Alert updated!"
      redirect_to alerts_path
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @outdoor_alert.delete
    @location.delete if @location.outdoor_alerts.empty?
    @phone.delete if @phone.outdoor_alerts.empty?

    redirect_to alerts_path
  end

  private

  def find_outdoor_alert_objects
    @outdoor_alert = OutdoorAlert.find(params[:id])
    @location = @outdoor_alert.location
    @phone = @outdoor_alert.phone
  end

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

  def twilio_bad_request
    flash[:alert] = 'The phone number you entered was not valid.'
    redirect_to new_outdoor_alert_path
  end
end
