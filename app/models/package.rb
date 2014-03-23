class Package < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  belongs_to :hour
  
  validates :addressee, presence: true
end
