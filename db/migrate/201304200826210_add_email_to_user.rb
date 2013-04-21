class AddEmailToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
  end


  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
