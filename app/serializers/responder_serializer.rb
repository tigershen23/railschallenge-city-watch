class ResponderSerializer < ActiveModel::Serializer
  self.root = 'responder' # or else it'll be the type of the responder

  attributes :emergency_code
  attributes :type
  attributes :name
  attributes :capacity
  attributes :on_duty
end
