class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.string :name
      t.string :youtube_id
      t.integer :subscriber_count
      t.integer :video_count
      t.integer :view_count

      t.timestamps
    end
  end
end
