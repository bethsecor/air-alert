class AirQualityController < ApplicationController
  before_action :authorize!

  def show
    if params[:address]
      @air_quality = AirQuality.air_quality(params[:address])
    else
      @air_quality = AirQuality.air_quality(current_user.location)
    end
  end
end
