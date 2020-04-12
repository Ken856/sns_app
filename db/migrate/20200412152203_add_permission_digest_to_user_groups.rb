class AddPermissionDigestToUserGroups < ActiveRecord::Migration[6.0]
  def change
    add_column :user_groups, :permission_digest, :string, null: false
  end
end
