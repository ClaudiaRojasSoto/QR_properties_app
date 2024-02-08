class Property < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
end
