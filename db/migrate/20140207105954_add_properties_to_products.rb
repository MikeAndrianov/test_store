class AddPropertiesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :additional_fields, :hstore
  end
end
