class AddParamsToCompanies < ActiveRecord::Migration
 def self.up
   add_column :companies, :product, :string
   add_column :companies, :price, :string
   add_column :companies, :product_id, :string
   add_column :companies, :image, :string
   add_column :companies, :product_url, :string
 end

 def self.down
   remove_column :companies, :product
   remove_column :companies, :price
   remove_column :companies, :product_id
   remove_column :companies, :image
   remove_column :companies, :product_url
 end
end
