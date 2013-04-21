class AddEmailToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :device_token, :string
  end


  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
