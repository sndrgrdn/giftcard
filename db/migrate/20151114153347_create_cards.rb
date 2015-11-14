class CreateCards < ActiveRecord::Migration
  def up
    create_table :cards do |c|
      c.string :name
      c.integer :value
      c.date :date
      c.timestamps
    end
  end

  def down
    drop_table :cards
  end
end
