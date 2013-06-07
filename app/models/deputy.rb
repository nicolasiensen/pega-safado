class Deputy < ActiveRecord::Base
  attr_accessible :name, :party, :uid, :state, :nickname
  belongs_to :party
  has_many :refunds
  has_many :companies, :through => :refunds
  validates :name, :party_id, :uid, :state, :nickname, presence: true
  validates :uid, :nickname, :uniqueness => true

  def most_suspicious_company
    refund = self.refunds.where("date >= ? AND date <= ?", (Date.today - 1.month).beginning_of_month, (Date.today - 1.month).end_of_month).order("value DESC").first
    if refund
      refund.company
    else
      nil
    end
  end
end
