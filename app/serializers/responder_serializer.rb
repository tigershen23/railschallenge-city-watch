class ResponderSerializer < ActiveModel::Serializer
  attributes :emergency_code
  attributes :type
  attributes :name
  attributes :capacity
  attributes :on_duty
end

