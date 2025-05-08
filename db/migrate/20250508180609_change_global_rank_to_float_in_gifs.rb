class ChangeGlobalRankToFloatInGifs < ActiveRecord::Migration[8.0]
  def change
    change_column :gifs, :global_rank, :float
  end
end
