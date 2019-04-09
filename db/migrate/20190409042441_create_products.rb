class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :image
      t.integer :price, null: false
      t.text :description
      t.boolean :published, null: false, default: true
      t.integer :position

      t.timestamps
    end
  end
end
