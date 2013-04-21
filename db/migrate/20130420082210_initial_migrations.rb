class InitialMigrations < ActiveRecord::Migration
  def self.up
    create_table :users do |u|
      u.string      'name', null: false
      u.timestamps
    end

    create_table :places do |p|
      p.integer     'user_id', null: false
      p.string      'name', null: false
      p.string      'address', null: false
      p.timestamps
    end

    create_table :commute_templates do |ct|
      ct.integer     'user_id', null: false
      ct.integer     'start_place_id', null: false
      ct.integer     'end_place_id', null: false
      ct.time        'arrive_by', null: false
      ct.string      'commute_mode', null: :false, default: :shortest_transit_time
      ct.string      'transportation_mode', null: :false, default: :car
      ct.string      'recurrence', null: :false, default: ''
      ct.timestamps
    end

    create_table :commutes do |c|
      c.integer     'commute_template_id', null: false
      c.integer     'user_id', null: false
      c.datetime    'occurs_at', null: false
      c.timestamps
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
