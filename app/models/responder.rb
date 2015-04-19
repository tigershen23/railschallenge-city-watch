class Responder < ActiveRecord::Base
  validates :name, uniqueness: true

  # Avoid STI; all types of Responders behave the same for now
  self.inheritance_column = nil
end
