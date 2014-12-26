class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.integer :prefecture_cd
      t.string :address
      t.string :phone_number
      t.string :web_site
      t.integer :latitude
      t.integer :longitude

      t.timestamps

    end
    
    add_index :places, :prefecture_cd
  end
end
