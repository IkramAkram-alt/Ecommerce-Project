class Product < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy

  validates :name,:brand, presence: true
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validate :image_type

  after_validation :set_serial_number

  def thumbnail input
    self.images[input].variant(resize: "150x150!").processed
  end

  def image_type
    if images.attached? == false
      errors.add(:images, "are missing!")
    end
    images.each do |image|
      if !image.content_type.in?(%("image/jpeg image/png image/jpg"))
        errors.add(:images, "Upload the valid Images")
      end
    end
  end

  def set_serial_number
    self.serial_no ="PDX-%.6d" % 1
  end
end
