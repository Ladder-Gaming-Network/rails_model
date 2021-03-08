class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.username :string
      t.firstname :string
      t.lastname :string
      t.timezone_code :int
      t.stream_link :string
      t.description :string

      t.timestamps
    end
  end
end
