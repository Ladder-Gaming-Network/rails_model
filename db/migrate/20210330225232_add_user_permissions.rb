class AddUserPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin_permissions,:boolean
  end
end
