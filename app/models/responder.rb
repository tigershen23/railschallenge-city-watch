class Responder < ActiveRecord::Base
  # Avoid STI; all Responders behave the same
  self.inheritance_column = nil
end
