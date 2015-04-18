module Domain
  module Dispatch
    # This class is responsible for handling available capacities and capacities needed
    class CapacityState
      attr_accessor :capacities, :capacity_needed

      def initialize(capacities, capacity_needed)
        @capacities = capacities
        @capacity_needed = capacity_needed
      end

      # See Responder#able_to_respond_capacities; the keys are responder id's
      def responder_ids
        capacities.keys
      end

      def responder_id_having_capacity(capacity)
        capacities.key(capacity)
      end

      def more_needed_than_available?
        capacity_available = capacities.values.sum

        capacity_needed > capacity_available
      end

      def capacities_less_than_needed
        capacities.select { |_, v| v < capacity_needed }
      end

      def capacities_greater_than_needed
        capacities.select { |_, v| v > capacity_needed }
      end
    end
  end
end
