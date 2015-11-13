class FixPolls < ActiveRecord::Migration
  def change
    remove_index :polls, :author_id
    add_index :polls, :author_id

  end
end
