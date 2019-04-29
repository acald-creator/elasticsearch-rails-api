class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :author
      t.text :body
      t.integer :post_id
      t.references :article
      t.timestamps null: false
    end
  end
end
