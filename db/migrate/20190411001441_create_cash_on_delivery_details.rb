class CreateCashOnDeliveryDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_on_delivery_details do |t|
      t.integer :price
      t.integer :more_than
      t.references :cash_on_delivery, foreign_key: true

      t.timestamps
    end
  end
end
