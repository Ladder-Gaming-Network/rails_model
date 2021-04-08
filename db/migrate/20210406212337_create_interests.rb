class CreateInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :interests do |t|
      t.integer :user_id
      t.string :interest

      t.timestamps
    end
  end
end
