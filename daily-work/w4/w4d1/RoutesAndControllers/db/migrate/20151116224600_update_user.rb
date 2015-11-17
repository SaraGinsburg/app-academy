class UpdateUser < ActiveRecord::Migration
  def change
    remove_column :users, :name, :string
    remove_column :users, :email, :string

    add_column :users, :username, :string, null: false, default:""
  end
end
