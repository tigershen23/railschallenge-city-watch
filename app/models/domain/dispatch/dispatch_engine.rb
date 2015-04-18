module Domain
  module Dispatch
    # This class is responsible for determining which responders the Dispatcher
    # should dispatch for a given emergency
    # Through .responder_for, it will return:
    # * just one responder, if that responder can handle the emergency completely
    # * just enough resources for an emergency
    # * all resources for an emergency that exceeds on-duty resources
    # * NO resources for an emergency with severities that are all zero
    class DispatchEngine
      def initialize(emergency)
        @emergency = emergency
      end

      # Returns an array of Responders to be assigned to the emergency
      def optimal_responders
        responder_ids = []
        ::Responder::TYPES.each do |type|
          responder_ids << optimal_responders_for_type(ActiveRecord::Base.const_get("::#{type}"))
        end

        ::Responder.where(id: responder_ids.flatten!)
      end

      private

      # Returns an array of appropriate responder_ids for the given Responder type
      def optimal_responders_for_type(type)
        available_capacities = type.able_to_respond_capacities # keys are id's, values are capacities
        capacity_needed = @emergency.type_severity(type)

        capacity_state = CapacityState.new(available_capacities, capacity_needed)
        return capacity_state.responder_ids if capacity_state.more_needed_than_available?

        optimal_responders_for_state(capacity_state)
      end

      def optimal_responders_for_state(capacity_state)
        responder_ids = []
        until capacity_state.capacity_needed <= 0
          responder_id = OptimalResponderCalculator.new(capacity_state).optimal_responder
          responder_ids << responder_id

          # Decrease capacity_needed by the capacity of the newly assigned responder,
          # delete that responder from the list of available capacities
          capacity_state.capacity_needed -= capacity_state.capacities.delete(responder_id)
        end

        responder_ids
      end
    end
  end
end
