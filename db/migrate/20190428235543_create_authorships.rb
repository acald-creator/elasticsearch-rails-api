class CreateAuthorships < ActiveRecord::Migration[5.2]
  def change
    create_table :authorships do |t|
      t.references :article, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps null: false
    end
  end
end
