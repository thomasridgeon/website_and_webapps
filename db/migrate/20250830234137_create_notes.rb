class CreateNotes < ActiveRecord::Migration[8.0]
  def change
    create_table :notes do |t|
      t.references :user, foreign_key: true
      t.text :ciphertext
      t.text :iv
      t.text :tag
      t.timestamps
    end
  end
end
