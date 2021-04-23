class AddTrackedToStreams < ActiveRecord::Migration[6.1]
  def change
    add_column :streams, :tracked, :boolean, :default => false
  end
end
