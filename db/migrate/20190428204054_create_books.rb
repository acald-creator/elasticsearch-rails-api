class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.boolean :published_at

      t.timestamps null: false
    end
  end
end
