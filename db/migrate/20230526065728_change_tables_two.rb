class ChangeTablesTwo < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :name, :string, null: false
    add_column :products, :description, :text, null: false
    add_column :products, :price, :decimal, :precision => 8, :scale => 2, null: false
    add_column :products, :balance, :integer, null: false

    add_reference :product_orders, :products, foreign_key: true, null: false
    add_reference :product_orders, :orders, foreign_key: true, null: false
    add_column :product_orders, :amount, :integer, null: false

    add_column :orders, :firstname, :string, null: false
    add_column :orders, :lastname, :string, null: false
    add_column :orders, :address, :string, null: false
    add_column :orders, :phone, :string, null: false
  end
end
