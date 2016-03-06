class CreateIndoorAlerts < ActiveRecord::Migration
  def change
    create_table :indoor_alerts do |t|
      t.string :name
      t.string :date
      t.references :phone, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
