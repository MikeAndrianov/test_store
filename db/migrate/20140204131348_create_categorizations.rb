class CreateCategorizations < ActiveRecord::Migration
  def up
    create_table :categorizations do |t|
      t.column :category_id, :integer
      t.column :product_id, :integer
    end
  end

  def down
    drop_table :categorizations
  end
end
