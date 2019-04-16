class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.date :delivery_date
      t.string :full_name
      t.string :post
      t.string :tel
      t.string :address
      t.integer :total_with_tax
      t.references :cash_on_delivery, foreign_key: true
      t.references :delivery_price, foreign_key: true
      t.references :tax, foreign_key: true
      t.references :user, foreign_key: true
      t.references :delivery_time_detail, foreign_key: true
      t.references :cart, foreign_key: true

      t.timestamps
    end
  end
end
