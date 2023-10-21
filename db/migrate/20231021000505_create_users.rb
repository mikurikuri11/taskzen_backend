class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.integer :active, default: 1
      t.integer :role, default: 0
      t.string :twitter_username
      t.string :avatar
      t.timestamps
    end
  end
end