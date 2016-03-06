class IndoorAlertsController < ApplicationController
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

  private

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
