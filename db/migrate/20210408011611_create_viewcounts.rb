class CreateViewcounts < ActiveRecord::Migration[6.1]
  def change
    create_table :viewcounts do |t|
      t.integer :stream_id
      t.integer :viewers
      t.datetime :timestamp

      t.timestamps
    end
  end
end
