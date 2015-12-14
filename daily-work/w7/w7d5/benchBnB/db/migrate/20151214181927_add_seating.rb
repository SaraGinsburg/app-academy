class AddSeating < ActiveRecord::Migration
  def change
    add_column :benches, :seating, :integer, index: true, null: false, default: 1
  end
end
