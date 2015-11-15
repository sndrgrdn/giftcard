class AddProductTitleToCompanies < ActiveRecord::Migration
 def self.up
   add_column :companies, :product_title, :string
 end

 def self.down
   remove_column :companies, :product_title
 end
end
