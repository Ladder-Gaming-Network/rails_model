class AddTwitchidToStreams < ActiveRecord::Migration[6.1]
  def change
    add_column :streams, :twitch_id, :string
  end
end
