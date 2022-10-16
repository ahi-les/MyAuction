class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.text :message
      t.datetime :start_date
      t.datetime :end_date
      t.string :sity
      t.integer :starting_price
      t.integer :buy_now
      t.belongs_to :category,      null: false, foreign_key: true
      t.belongs_to :gender,        null: true, foreign_key: true
      t.belongs_to :condition,     null: false, foreign_key: true
      t.belongs_to :user,          null: false, foreign_key: true
      t.belongs_to :status,        null: false, foreign_key: true

      t.timestamps
    end
  end
end
