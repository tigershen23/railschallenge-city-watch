class EmergencySerializer < ActiveModel::Serializer
  attributes :code
  attributes :fire_severity
  attributes :police_severity
  attributes :medical_severity
  attributes :resolved_at
  attributes :full_response
  attributes :responders

  def responders
    object.responders.pluck(:name)
  end
end
