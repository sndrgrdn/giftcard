class CreateCompanies < ActiveRecord::Migration
  def up
    create_table :companies do |c|
      c.string :name
      c.string :url
      c.timestamps
    end
  end

  def down
    drop_table :companies
  end
end
