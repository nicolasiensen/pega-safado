class Company < ActiveRecord::Base
  attr_accessible :cnpj, :name
  has_many :refunds
  validates :cnpj, :name, presence: true
  validates :cnpj, uniqueness: true
end
