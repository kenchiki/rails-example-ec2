class CreateDeliveryPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_prices do |t|
      t.integer :price
      t.integer :per

      t.timestamps
    end
  end
end
