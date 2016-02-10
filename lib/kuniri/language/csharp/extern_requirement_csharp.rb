require_relative '../abstract_container/structured_and_oo/extern_requirement'
require_relative '../container_data/structured_and_oo/extern_requirement_data'

module Languages

  module Csharp

    # ExternRequirement Handling extern requirements.
    class ExternRequirementCsharp < Languages::ExternRequirement

      public

        # Get Csharp requirement.
        # @see ExternRequirement
        def get_requirement(pLine)
          # YOUR CODE HERE
        end

      protected

        # Override
        def detect_extern_requirement(pLine)
          # YOUR CODE HERE
        end

        # Override
        def remove_unnecessary_information(pLine)
          # YOUR CODE HERE
        end

    # Class
    end

  # Module
  end

# Module
end 
