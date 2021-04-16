class IncreasIntegerLimitForViewcountId < ActiveRecord::Migration[6.1]
  def change
    change_column :viewcounts, :stream_id, :integer, limit: 8
  end
end
