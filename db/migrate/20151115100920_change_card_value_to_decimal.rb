class ChangeCardValueToDecimal < ActiveRecord::Migration
  def self.up
    change_table :cards do |t|
      t.change :value, :decimal
    end
  end
  def self.down
    change_table :cards do |t|
      t.change :value, :integer
    end
  end
end
