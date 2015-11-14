class AddScndCodeToCards < ActiveRecord::Migration
 def self.up
   add_column :cards, :scnd_code, :string
 end

 def self.down
   remove_column :cards, :scnd_code
 end
end
