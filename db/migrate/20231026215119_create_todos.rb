class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.date :due_date
      t.boolean :completed
      t.integer :zone

      t.timestamps
    end
  end
end
