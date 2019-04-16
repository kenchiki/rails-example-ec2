class CreateDeliveryTimeDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_time_details do |t|
      t.string :time
      t.references :delivery_time, foreign_key: true

      t.timestamps
    end
  end
end
