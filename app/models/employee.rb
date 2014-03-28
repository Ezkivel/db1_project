class Employee < ActiveRecord::Base
  belongs_to :station
  has_many :packages
  has_many :tickets
  has_one :bus
  
  validates :identity, :name, :surname, :email, presence: true
  validates_format_of :email, :with => Devise::email_regexp
  validates :email, uniqueness: true
end
