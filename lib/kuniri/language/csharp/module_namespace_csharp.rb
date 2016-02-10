require_relative '../abstract_container/structured_and_oo/module_namespace'
require_relative '../container_data/structured_and_oo/module_namespace_data'

module Languages

  module Csharp

    # Class for handling Csharp module
    class ModuleNamespaceCsharp < Languages::ModuleNamespace

      public

        # Get Csharp module.
        # @see Languages::ModuleNamespace
        def get_module(pLine)
          # YOUR CODE HERE
        end

      protected

        # Override
        def detect_module(pLine)
          # YOUR CODE HERE
        end

        # Override
        def remove_unnecessary_information(pLine)
          # YOUR CODE HERE
        end

    # class
    end

  # module
  end

# module
end
