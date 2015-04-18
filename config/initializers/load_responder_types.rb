# Dynamically create a new class for each Responder type
Responder::TYPES.each do |klass_name|
  klass = Class.new(Responder)
  Object.const_set(klass_name, klass)
end

# Dynamically create a new serializer for each Responder type
Responder::TYPES.each do |klass_name|
  klass = Class.new(ResponderSerializer)
  Object.const_set("#{klass_name}Serializer", klass)
  klass
end
