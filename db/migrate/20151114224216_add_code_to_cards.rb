class AddCodeToCards < ActiveRecord::Migration
 def self.up
   add_column :cards, :code, :string
 end

 def self.down
   remove_column :cards, :code
 end
end
