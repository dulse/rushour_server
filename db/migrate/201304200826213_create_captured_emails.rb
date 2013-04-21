class CreateCapturedEmails < ActiveRecord::Migration
  def self.up
    create_table :captured_emails do |u|
      u.string      'email', null: false
    end
  end


  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
