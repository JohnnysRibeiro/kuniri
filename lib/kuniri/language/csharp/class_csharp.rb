require_relative '../abstract_container/structured_and_oo/class'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../../core/setting'

module Languages

  module Csharp

    # Class responsible for handling Csharp classes.
    class ClassCsharp < Languages::Class

      public

        def initialize
          # YOUR CODE HERE
        end

        # Get Csharp class.
        # @see Languages::Class
        def get_class(pLine)
          result = detect_class(pLine)
          return nil unless result

          classCaptured = Languages::ClassData.new

          inheritance = get_inheritance(result)
          classCaptured.inheritances = inheritance if inheritance

          result = prepare_final_string(result)
          classCaptured.name = result

          return classCaptured
        end

      protected

        # Override
        def detect_class(pLine)
          pLine.gsub!(/\s{2,}/," ")
          return nil if pLine =~ /^\s?\/\/|^\s?\/\*/
          regexExpression = /\s?class\s(.*)/
          return nil unless pLine =~ regexExpression
          return pLine.scan(regexExpression)[0].join("")
        end

        # Override
        def get_inheritance(pString)
          if pString =~ /:/
            partial = pString.scan(/:\s*(\w+)\s*/)
            return remove_unnecessary_information(partial)
          end
          return nil
        end

        # Override
        def remove_unnecessary_information(pString)
          return pString.gsub(/\s*|:|\{/, "") if pString =~ /\s|:|\{/
          return pString
        end

        def prepare_final_string(pString)
          if pString =~ /\s|:/
            partial = pString.gsub(/:.*/,"")
            return remove_unnecessary_information(partial)
          end
          return pString
        end

      private
        # YOU CAN HAVE CODE HERE...

    # class
    end

  # Csharp
  end

# Languages
end