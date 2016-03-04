class CreateOutdoorAlerts < ActiveRecord::Migration
  def change
    create_table :outdoor_alerts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.references :phone, index: true, foreign_key: true
      t.string :reason, default: "general"
      t.integer :poor, default: 0
      t.integer :low, default: 0
      t.integer :moderate, default: 0
      t.integer :fair, default: 0
      t.integer :excellent, default: 0

      t.timestamps null: false
    end
  end
end
