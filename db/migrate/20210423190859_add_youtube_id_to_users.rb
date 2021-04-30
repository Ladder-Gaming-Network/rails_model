class AddYoutubeIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :youtube_id, :string
  end
end
