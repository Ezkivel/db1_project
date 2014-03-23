class Hour < ActiveRecord::Base
  has_many :tickets
  has_many :packages
  belongs_to :bus
  has_and_belongs_to_many :stations
end
