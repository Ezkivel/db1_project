class Customer < ActiveRecord::Base
  has_many :packages
  has_one :ticket
  
  validates :identity, :name, :surname, presence: true
  validates :identity, numericality: { only_integer: true }
  validates :identity, length: { minimum: 13 }, length: { maximum: 13 }
end
