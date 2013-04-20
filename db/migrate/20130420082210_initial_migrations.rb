class InitialMigrations < ActiveRecord::Migration
  def self.up
    create_table :users do |u|
      u.string      'name', null: false
      u.timestamps
    end

    create_table :places do |p|
      p.string      'name', null: false
      p.string      'address', null: false
      p.timestamps
    end

    create_table :commute_templates do |ct|
      ct.time        'arrive_by', null: false
      ct.string      'commute_mode', null: :false, default: :shortest_transit_time
      ct.string      'transportation_mode', null: :false, default: :car
      ct.string      'recurrence', null: :false, default: ''
    end

    create_table :commute do |c|
      c.datetime    'occurs_at', null: false
    end

    add_foreign_key(:places, :users, dependent: :delete)
    add_foreign_key(:commute_templates, :users, dependent: :delete)
    add_foreign_key(:commutes, :users, dependent: :delete)

    add_foreign_key(:commute_templates, :places, name: 'start', dependent: :delete)
    add_foreign_key(:commute_templates, :places, name: 'end', dependent: :delete)
    add_foreign_key(:commutes, :commute_templates, dependent: :delete)
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
