class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.integer :price
      t.belongs_to :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
