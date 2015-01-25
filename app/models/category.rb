class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :tickets
  has_many :merchant_infos
end
