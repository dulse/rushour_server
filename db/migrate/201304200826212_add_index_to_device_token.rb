class AddIndexToDeviceToken < ActiveRecord::Migration
  def self.up
    add_index :users, :device_token, :unique => true
  end


  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
