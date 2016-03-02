class AlertsController < ApplicationController
  def index
    @outdoor_alerts = current_user.outdoor_alerts
  end
end
