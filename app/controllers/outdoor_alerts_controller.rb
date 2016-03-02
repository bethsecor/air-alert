class OutdoorAlertsController < ApplicationController
  def new
    @outdoor_alert = OutdoorAlert.new
  end
end
