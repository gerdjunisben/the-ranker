class AddRankingAndUserModelsAndAddFieldToGifs < ActiveRecord::Migration[8.0]
  def change
    create_table :rankings do |t|
      t.references :gif, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :rank
      t.timestamps
    end
  end
end
