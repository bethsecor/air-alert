class CreateOutdoorAlerts < ActiveRecord::Migration
  def change
    create_table :outdoor_alerts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.references :phone, index: true, foreign_key: true
      t.string :reason
      t.boolean :poor
      t.boolean :low
      t.boolean :moderate
      t.boolean :fair
      t.boolean :excellent

      t.timestamps null: false
    end
  end
end
