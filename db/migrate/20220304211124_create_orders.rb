class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :customer_id
      t.string :blend
      t.integer :volume
      t.date :day
      t.boolean :fulfilled

      t.timestamps
    end
  end
end
