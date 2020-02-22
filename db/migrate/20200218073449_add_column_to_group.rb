class AddColumnToGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :groups, :room_id, :integer
  end
end
