class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :body, null: false
      t.integer :tweet_id, null: false

      t.timestamps null: false
    end
  end
end
