class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :lastname
      t.string :stream_link
      t.string :description
      t.integer :timezone_code

      t.timestamps
    end
  end
end
