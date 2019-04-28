class CreateShippingAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_addresses do |t|
      t.string :full_name
      t.string :post
      t.string :tel
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
