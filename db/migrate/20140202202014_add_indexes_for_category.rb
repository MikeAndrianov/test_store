class AddIndexesForCategory < ActiveRecord::Migration
  def change
    add_index :categories, [:parent_id, :lft, :rgt]
  end
end
