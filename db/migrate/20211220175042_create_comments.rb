class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.bigint :author_id
      t.bigint :post_id
      t.text :text
    end
    add_foreign_key :comments, :users,  column: :author_id
    add_foreign_key :comments, :posts, column: :post_id

    add_index :comments, :author_id
    add_index :comments, :post_id
  end
end