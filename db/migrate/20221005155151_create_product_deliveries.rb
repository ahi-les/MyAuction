class CreateProductDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :product_deliveries do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :delivery, null: false, foreign_key: true

      t.timestamps
    end

    add_index :product_deliveries, [:product_id, :delivery_id], unique: true
  end
end
