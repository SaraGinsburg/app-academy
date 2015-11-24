class ReCreateTweets < ActiveRecord::Migration
  def change
    drop_table :tweets
    create_table :tweets do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
