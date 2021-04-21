class AddUserIdToChannels < ActiveRecord::Migration[6.1]
  def change
    add_column :channels, :user_id, :integer
  end
end
