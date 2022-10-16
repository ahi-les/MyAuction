class CreateProductPayments < ActiveRecord::Migration[6.1]
  def change
    create_table :product_payments do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :payment, null: false, foreign_key: true

      t.timestamps
    end
    add_index :product_payments, [:product_id, :payment_id], unique: true
  end
end
