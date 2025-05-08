class AddRankingsArrayToGifs < ActiveRecord::Migration[8.0]
  def change
    add_column :gifs, :rankings_array, :jsonb, default: Array.new(11, 0)
  end
end
