json.extract! gallery, :id, :image_title, :image_description, :image, :category, :item_for_sale, :created_at, :updated_at
json.url gallery_url(gallery, format: :json)
