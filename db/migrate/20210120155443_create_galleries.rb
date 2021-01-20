class CreateGalleries < ActiveRecord::Migration[6.0]
  def change
    create_table :galleries do |t|
      t.string :image_title
      t.string :image_description
      t.string :image
      t.string :category
      t.boolean :item_for_sale

      t.timestamps
    end
  end
end
