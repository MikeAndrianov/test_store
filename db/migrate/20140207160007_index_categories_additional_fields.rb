class IndexCategoriesAdditionalFields < ActiveRecord::Migration
  def up
    execute "CREATE INDEX categories_additional_fields ON categories USING GIN(additional_fields)"
  end

  def down
    execute "DROP INDEX categories_additional_fields"
  end
end
