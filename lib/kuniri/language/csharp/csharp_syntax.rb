require_relative '../language'
require_relative '../container_data/structured_and_oo/class_data'
require_relative '../container_data/structured_and_oo/file_element_data'
require_relative 'token_csharp'
require_relative 'extern_requirement_csharp'
require_relative 'variable_global_csharp'
require_relative 'module_namespace_csharp'
require_relative 'end_block_csharp'
require_relative 'constructor_csharp'
require_relative 'class_csharp'
require_relative 'conditional_csharp'
require_relative 'repetition_csharp'
require_relative 'function_behavior_csharp'
require_relative 'attribute_csharp'
require_relative 'comment_csharp'
require_relative 'method_csharp'
require_relative 'aggregation_csharp'
require_relative '../metadata'

module Languages

  # Handling the Csharp syntax for extract information.
  class CsharpSyntax < Languages::Language

    public

      def initialize
        super
        @externRequirementHandler = Languages::Csharp::ExternRequirementCsharp.new
        @variableHandler = Languages::Csharp::VariableGlobalCsharp.new
        @functionHandler = Languages::Csharp::FunctionBehaviorCsharp.new
        @moduleHandler = Languages::Csharp::ModuleNamespaceCsharp.new
        @classHandler = Languages::Csharp::ClassCsharp.new
        @attributeHandler = Languages::Csharp::AttributeCsharp.new
        @endBlockHandler = Languages::Csharp::EndBlockCsharp.new
        @methodHandler = Languages::Csharp::MethodCsharp.new
        @constructorHandler = Languages::Csharp::ConstructorCsharp.new
        @conditionalHandler = Languages::Csharp::ConditionalCsharp.new
        @repetitionHandler = Languages::Csharp::RepetitionCsharp.new
        @commentHandler = Languages::Csharp::CommentCsharp.new
        @aggregationHandler = Languages::Csharp::AggregationCsharp.new
        @metadata = Languages::Metadata.create
        @visibility = "public"
      end

      # Analyse source code.
      # @param pPath Path of file to be analysed.
      def analyse_source(pPath)
        @name = File.basename(pPath, ".*")
        @path = File.dirname(pPath)
        analyse_first_step(pPath)
        analyse_second_step
      end

    private

      attr_accessor :visibility
      @source
      @flagMultipleLineComment = false

      # Puts every statement in a single line
      # @param pLine Line of the file to be analysed.
      def handle_semicolon(pLine)
        commentLine = []

        if pLine =~ /\/\*/
          @flagMultipleLineComment = true
        elsif pLine =~ /\*\//
          @flagMultipleLineComment = false
        end

        unless @flagMultipleLineComment == true || pLine =~ /\/\/(.*)/
          return pLine.split(/;/)
        end
        commentLine << pLine
      end

      # First step for analyse code, it is responsible for get only basic
      # informations.
      # @param pPath Path of file to be analysed.
      def analyse_first_step(pPath)
        fileElement = Languages::FileElementData.new(pPath)
        @source = File.open(pPath, "rb")
        @source.each do |line|
          next if line.gsub(/\s+/,"").size == 0
          processedLines = handle_semicolon(line)
          if !processedLines.nil?
            processedLines.each do |line|
              @state.handle_line(line)
              fileElement = @state.execute(fileElement, line)
            end
          end
        end

        @source.close()
        @fileElements.push(fileElement)

      end

      def analyse_second_step
        sort_all_classes
        sort_all_aggregations

        allActualAggregations = []

        @metadata.allAggregations.each do |element|
          if binary_search(@metadata.allClasses, element)
            allActualAggregations << element
          end
        end

        # TODO: Think how to improve.
        @fileElements.each do |fileElement|
          fileElement.classes.each do |classes|
            classes.aggregations.delete_if do |aggregation|
              unless allActualAggregations.include? aggregation
                true
              end
            end
          end
        end
      end

      # TODO: Move it to utils
      def binary_search(pVector, pElement)
        pVector.bsearch {|obj| pElement.name <=> obj.name}
      end

      # TODO: Move it to utils
      def sort_all_classes
        @metadata.allClasses.sort! {|c1, c2| c1.name <=> c2.name}
      end

      # TODO: Move it to utils
      def sort_all_aggregations
        @metadata.allAggregations.sort! {|a1, a2| a1.name <=> a2.name}
        @metadata.allAggregations.uniq! {|a| a.name}
      end

  # Class
  end

# Module
end
