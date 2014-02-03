class AddFieldsForNestingToCategory < ActiveRecord::Migration
  def change
    change_table :categories do |t|
      t.column :parent_id, :integer
      t.column :lft, :integer
      t.column :rgt, :integer
    end
  end
end
