class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title

      t.timestamps null: false

      add_index(:comments, :article_id) unless index_exists?(:comments, :article_id)
    end
  end
end
