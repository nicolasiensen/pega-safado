class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :refunds
  validates :name, presence: true
  validates :name, uniqueness: true
end
