class Bus < ActiveRecord::Base
  has_many :hour
  belongs_to :employee
end
