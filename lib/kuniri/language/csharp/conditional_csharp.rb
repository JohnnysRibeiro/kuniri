require_relative '../abstract_container/structured_and_oo/conditional'
require_relative '../abstract_container/structured_and_oo/global_tokens'
require_relative '../container_data/structured_and_oo/conditional_data'

module Languages

  module Csharp

    # Class responsible for handling Csharp conditional statements.
    class ConditionalCsharp < Languages::Conditional

      public

        # Get Csharp conditional.
        # @see Languages::Conditional
        def get_conditional(pLine)
          # YOUR CODE HERE
        end

      protected

        # Override.
        def detect_conditional(pLine)
          # YOUR CODE HERE
        end

        # Override
        def conditional_type(pString)
          # YOUR CODE HERE
        end

        # Override
        def get_expression(pString)
          # YOUR CODE HERE
        end

    # Class
    end

  # Module
  end

# Module
end
