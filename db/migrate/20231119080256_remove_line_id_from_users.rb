class RemoveLineIdFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :line_id, :string
  end
end
