# This class is responsible for calculating the responder capacity
# at a given time
module Domain
  module Reports
    class CapacityReport
      # The four numbers returned for each type, in order, are as follows:
      # * The total capacity of all responders in the city, by type
      # * The total capacity of all "available" responders (not currently assigned to an emergency)
      # * The total capacity of all "on-duty" responders, including those currently handling emergencies
      # * The total capacity of all "available, AND on-duty" responders (the responders currently
      #   available to jump into a new emergency)
      #
      # Example return:
      # {
      #   'Fire' => [3, 3, 2, 2],
      #   'Police' => [7, 7, 3, 3],
      #   'Medical' => [6, 6, 6, 6]
      # }
      def self.calculate
        capacity = {}
        ::Responder::TYPES.each do |type|
          capacity[type] = calculate_for_type(type)
        end

        capacity
      end

      # Return an array of availabilities for one Responder type, e.g.
      # [3, 3, 2, 2] for Fire in the example for .calculate
      def self.calculate_for_type(type)
        klass = type.constantize

        [
          klass.sum_capacity,
          klass.scope_capacity(:available),
          klass.scope_capacity(:on_duty),
          klass.scope_capacity(:able_to_respond)
        ]
      end
    end
  end
end
