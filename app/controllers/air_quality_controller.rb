class AirQualityController < ApplicationController
  before_action :authorize!

  def show
    if params[:air_quality_search]
      @air_quality = AirQuality.air_quality(params[:air_quality_search][:address])
    else
      @air_quality = AirQuality.air_quality(current_user.location)
    end
  end
end
