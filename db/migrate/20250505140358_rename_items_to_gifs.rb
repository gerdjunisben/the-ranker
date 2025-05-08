class RenameItemsToGifs < ActiveRecord::Migration[8.0]
  def change
    rename_table :items, :gifs
    add_column :gifs, :global_rank, :integer
    add_column :gifs, :rank_count, :integer
  end
end
