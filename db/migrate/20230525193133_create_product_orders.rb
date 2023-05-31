class CreateProductOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :product_orders do |t|
      t.references :product_id, foreign_key: true, null: false
      t.references :order_id, foreign_key: true, null: false
      t.integer :amount, null:false, default: 1

      t.timestamps
    end
  end
end
