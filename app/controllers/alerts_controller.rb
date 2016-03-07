class AlertsController < ApplicationController
  def index
    @outdoor_alerts = current_user.outdoor_alerts
    @indoor_alerts = current_user.indoor_alerts
  end
end
