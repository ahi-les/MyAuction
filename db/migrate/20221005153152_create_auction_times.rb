class CreateAuctionTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :auction_times do |t|
      t.datetime :time

      t.timestamps
    end
  end
end
