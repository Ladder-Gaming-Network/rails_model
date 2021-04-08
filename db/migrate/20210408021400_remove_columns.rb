class RemoveColumns < ActiveRecord::Migration[6.1]
  def self.up
    remove_column :viewcounts, :timestamp
  end

  def self.down
    add_column :viewcounts, :timestamp, :datetime
  end
end
