class CreateTodoCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :todo_categories do |t|
      t.integer :todo_id
      t.integer :category_id

      t.timestamps
    end
  end
end
