class CreateDeliveryTimes < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_times do |t|

      t.timestamps
    end
  end
end
