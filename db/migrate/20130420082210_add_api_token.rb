class AddUniqConstraintOnCityDealDeal < ActiveRecord::Migration
  def up
    add_column :users, :api_token, :string
    add_index :users, :api_token, :unique => true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
