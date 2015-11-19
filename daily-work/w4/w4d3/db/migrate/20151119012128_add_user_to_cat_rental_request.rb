class AddUserToCatRentalRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer, null: false
    add_foreign_key :cat_rental_requests, :users
    add_index :cat_rental_requests, :user_id
  end
end
