class ChangeIssues < ActiveRecord::Migration
  def change
	add_column :issues, :likes, :integer, null: false, default: 0
	add_index :issues, :likes
  end
end
