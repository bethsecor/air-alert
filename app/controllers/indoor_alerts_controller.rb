class IndoorAlertsController < ApplicationController
  before_action :authorize!
  before_action :find_indoor_alert_objects, only: [:edit, :destroy]
  rescue_from Twilio::REST::RequestError, with: :twilio_bad_request

  def new
    @indoor_alert = IndoorAlert.new
    @phone = Phone.new
  end

  def create
    @phone, @indoor_alert = IndoorAlertCreator.make(phone_params,
                                                     indoor_alert_params,
                                                     current_user)
    if @phone.errors.messages.empty? & @indoor_alert.save
      @indoor_alert.initial_alert
      flash[:success] = "Indoor Air Filter reminder created!"
      redirect_to alerts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @phone, @indoor_alert = IndoorAlertCreator.update(params[:id],phone_params,
                                                     indoor_alert_params,
                                                     current_user)
  if @phone.errors.messages.empty? & @indoor_alert.save
      flash[:success] = "Indoor Air Filter reminder updated!"
      redirect_to alerts_path
    else
      render :edit
    end
  end

  def destroy
    @indoor_alert.delete
    @phone.delete if @phone.indoor_alerts.empty? & @phone.outdoor_alerts.empty?

    redirect_to alerts_path
  end

  private

  def find_indoor_alert_objects
    @indoor_alert = IndoorAlert.find(params[:id])
    @phone = @indoor_alert.phone
  end

  def indoor_alert_params
    params.require(:indoor_alert).permit(:name, :date)
  end

  def phone_params
    params.require(:phone).permit(:number)
  end

  def twilio_bad_request
    flash[:alert] = 'The phone number you entered was not valid. Please delete alert.'
    redirect_to alerts_path
  end
end
