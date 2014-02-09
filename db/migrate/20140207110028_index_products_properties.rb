class IndexProductsProperties < ActiveRecord::Migration
  def up
    execute "CREATE INDEX products_additional_fields ON products USING GIN(additional_fields)"
  end

  def down
    execute "DROP INDEX products_additional_fields"
  end
end
