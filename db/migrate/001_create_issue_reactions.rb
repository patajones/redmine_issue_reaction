class CreateIssueReactions < ActiveRecord::Migration
  def change
    create_table :issue_reactions do |t|
      t.integer :reaction, null: false, default: 1
      t.references :user, foreign_key: true, null: false
      t.references :issue, foreign_key: true, null: false
    end
    add_index :issue_reactions, [:user_id,:issue_id], unique: true    
  end
end
