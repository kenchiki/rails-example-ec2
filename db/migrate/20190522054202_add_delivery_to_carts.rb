class AddDeliveryToCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :delivery_date, :date
    add_reference :carts, :delivery_time_detail, foreign_key: true
  end
end
