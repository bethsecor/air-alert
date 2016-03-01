class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :name
      t.string :nickname
      t.string :location
      t.string :token
      t.string :secret

      t.timestamps null: false
    end
  end
end
