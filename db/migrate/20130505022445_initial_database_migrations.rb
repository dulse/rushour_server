class InitialDatabaseMigrations < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :device_id
      u.timestamps
    end
    create_table :locations do |l|
      l.string :name
      l.string :address
      l.string :lat_long
      l.timestamps
    end
    create_table :trips do |t|
      t.string :trans_mode
      t.integer :start_location_id
      t.integer :end_location_id
      t.string :hueristic
      t.string :h_value
      t.time   :preptime
      t.timestamps
    end
    create_table :commutes do |c|
      c.references :trip
      c.string :schedule
      c.timestamps
    end
    create_table :commute_instances do |c|
      c.time :occured_at
      c.references :commute
      c.timestamps
    end

  end
end
