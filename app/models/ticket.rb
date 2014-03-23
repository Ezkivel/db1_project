class Ticket < ActiveRecord::Base
  belongs_to :customer
  belongs_to :employee
  belongs_to :hour
end