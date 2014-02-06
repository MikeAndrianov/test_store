class ChangeIdFieldsToSlugInCategorizations < ActiveRecord::Migration
  def change    
    add_column :categorizations, :product_slug, :string
    add_column :categorizations, :category_slug, :string
  end
end
