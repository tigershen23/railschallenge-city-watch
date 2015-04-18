module Domain
  module Dispatch
    # This class is responsible for moving Responders around in
    # response to new and resolved emergencies
    class Dispatcher
      def self.dispatch(emergency)
        optimal_responders = DispatchEngine.new(emergency).optimal_responders
        emergency.responders = optimal_responders

        full_response = FullResponseCalculator.new(emergency).fully_responded_to?
        emergency.update(full_response: full_response)
      end

      def self.resolve(emergency, resolved_at)
        emergency.responders.clear if resolved_at.present?
      end
    end
  end
end
