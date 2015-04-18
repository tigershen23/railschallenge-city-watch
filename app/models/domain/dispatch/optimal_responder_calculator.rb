module Domain
  module Dispatch
    # This class is responsible for determining the best responder
    # for a given situation (available capacities and capacity needed)
    class OptimalResponderCalculator
      def initialize(capacity_state)
        @capacity_state = capacity_state
      end

      def optimal_responder
        exact_match_id = @capacity_state.responder_id_having_capacity(@capacity_state.capacity_needed)
        alternative_id = optimal_alternative_id

        exact_match_id || alternative_id
      end

      private

      # The best alternative responder_id is determined as followed:
      # The largest remaining capacity that's less than capacity_needed OR
      # If none exist, the fallback is to use the smallest capacity that's greater than capacity_needed
      def optimal_alternative_id
        preferred_id = preferred_alternative_id
        fallback_id = non_preferred_alternative_id

        preferred_id || fallback_id
      end

      # Determines a preferred alternative id that's as great as possible
      # but less than the capacity needed
      def preferred_alternative_id
        less_than_needed = @capacity_state.capacities_less_than_needed

        less_than_needed.max_by { |_, v| v }.to_a[0]
      end

      # Determines a non-preferred, fallback alternative id that is greater than the capacity needed
      # while being as small as possible
      def non_preferred_alternative_id
        greater_than_needed = @capacity_state.capacities_greater_than_needed

        greater_than_needed.min_by { |_, v| v }.to_a[0] # The smallest remaining capacity > capacity_needed
      end
    end
  end
end
