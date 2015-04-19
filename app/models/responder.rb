class Responder < ActiveRecord::Base
  VALID_CAPACITIES = 1..5

  validates :name, uniqueness: true
  validates :capacity, presence: true, inclusion: VALID_CAPACITIES

  # Avoid STI; all types of Responders behave the same for now
  self.inheritance_column = nil
end
