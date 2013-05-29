class Deputy < ActiveRecord::Base
  attr_accessible :name, :party, :uid, :state, :nickname
  belongs_to :party
  has_many :refunds
  has_many :companies, :through => :refunds
  validates :name, :party_id, :uid, :state, :nickname, presence: true
  validates :uid, :nickname, :uniqueness => true
end
