class CreateCashOnDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_on_deliveries do |t|

      t.timestamps
    end
  end
end
