class SuspiciousCompany < ActiveRecord::Base
  attr_accessible :company_id, :deputy_id, :rank, :total_refunds
  belongs_to :deputy
  belongs_to :company
end
