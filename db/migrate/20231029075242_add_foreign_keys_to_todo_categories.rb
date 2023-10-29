class AddForeignKeysToTodoCategories < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :todo_categories, :todos, column: :todo_id, foreign_key: true
    add_foreign_key :todo_categories, :categories, column: :category_id, foreign_key: true
  end
end
