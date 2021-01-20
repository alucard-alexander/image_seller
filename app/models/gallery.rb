class Gallery < ApplicationRecord
  mount_uploader :image, ImageUploader

  has_one :image_price

  validate :validate_minimum_image_size



  def validate_minimum_image_size
    image = MiniMagick::Image.open(self.image.path)
    errors.add :image, 'should be 2000px minimum!' unless image[:width] >= 2000
  end
end
