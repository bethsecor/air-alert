class AirQualityController < ApplicationController
  before_action :authorize!

  def show
    if params[:air_quality_search]
      @air_quality = AirQuality.air_quality(params[:air_quality_search][:address])
      @message = "#{@air_quality.breezometer_description} in #{params[:air_quality_search][:address]}." \
                 " #{@air_quality.random_recommendations[:outside]}." unless @air_quality.error
    else
      @air_quality = AirQuality.air_quality(current_user.location)
      @message = "#{@air_quality.breezometer_description} in #{current_user.location}." \
                 " #{@air_quality.random_recommendations[:outside]}." unless @air_quality.error
    end
  end
end
