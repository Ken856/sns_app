class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :notifier_id, null: false
      t.integer :notified_id, null: false
      t.integer :group_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false


      t.timestamps
    end
    add_index :notifications, :notifier_id
    add_index :notifications, :notified_id
    add_index :notifications, :group_id
  end
end
