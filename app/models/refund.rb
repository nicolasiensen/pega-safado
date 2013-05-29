class Refund < ActiveRecord::Base
  attr_accessible :company, :deputy, :invoice, :value, :category
  belongs_to :company
  belongs_to :deputy
  belongs_to :category
  validates :company_id, :deputy_id, :invoice, :value, :category_id, presence: true
  validates :invoice, uniqueness: { :scope => :company_id }
end
