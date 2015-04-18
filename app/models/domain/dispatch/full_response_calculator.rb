module Domain
  module Dispatch
    # This class is responsible for determining if an emergency
    # has a full response based on its responders and severity
    class FullResponseCalculator
      def initialize(emergency)
        @emergency = emergency
      end

      # Determine if there was a full response to the emergency
      # (i.e. that the responder capacities adequately cover the
      # emergency severity for each type)
      def fully_responded_to?
        ::Responder::TYPES.each do |type|
          return false unless full_response_for_type?(type)
        end

        true
      end

      def full_response_for_type?(type)
        type_scope = ::Responder.type_scope(type) # Scope name for type: fires, etc. for each type

        capacity = @emergency.responders.send(type_scope).sum_capacity
        severity = @emergency.type_severity(type)

        # There is a full response for type if capacity covers severity
        capacity >= severity
      end
    end
  end
end
