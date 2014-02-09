class AddAdditionalFieldsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :additional_fields, :hstore
  end
end
