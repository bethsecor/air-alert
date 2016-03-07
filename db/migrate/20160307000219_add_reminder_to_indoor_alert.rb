class AddReminderToIndoorAlert < ActiveRecord::Migration
  def change
    add_column :indoor_alerts, :reminder, :date
  end
end
