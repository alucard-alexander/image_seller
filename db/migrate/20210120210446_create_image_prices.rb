class CreateImagePrices < ActiveRecord::Migration[6.0]
  def change
    create_table :image_prices do |t|
      t.integer :gallery_id
      t.float :price

      t.timestamps
    end
  end
end
