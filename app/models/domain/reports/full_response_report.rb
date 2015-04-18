module Domain
  module Reports
    # This class is responsible for generating a simple report
    # on the number of emergencies with full responses and the
    # number of total emergencies
    class FullResponseReport
      def self.calculate
        [::Emergency.full_responses_count, ::Emergency.count]
      end
    end
  end
end
