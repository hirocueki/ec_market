class Item < ApplicationRecord
  validates :name, :price, presence: true

  belongs_to :shop
  acts_as_list scope: :shop
  mount_uploader :image, ImageUploader
  scope :displayed, -> { where(hidden: false) }
end
