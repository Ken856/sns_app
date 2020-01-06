class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :board_id
      t.string :body, null: false

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :board_id
  end
end
