class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :text
      t.integer :parent_post

      t.timestamps
    end
  end
end
