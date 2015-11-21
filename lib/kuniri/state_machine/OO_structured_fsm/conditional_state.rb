require_relative 'oo_structured_state'

module StateMachine

  module OOStructuredFSM

    # Class responsible for handling conditional state.
    class ConditionalState < OOStructuredState

      MAP_STATE =
      {
        StateMachine::METHOD_STATE => StateMachine::METHOD_LABEL,
        StateMachine::CONSTRUCTOR_STATE => StateMachine::CONSTRUCTOR_LABEL,
        StateMachine::GLOBAL_FUNCTION_STATE => StateMachine::FUNCTION_LABEL
      }

      @language

      def initialize(pLanguage)
        @language = pLanguage
      end

      def handle_line(pLine)
        if @language.conditionalHandler.get_internal_conditional(pLine)
          conditional_capture
        elsif @language.repetitionHandler.get_repetition(pLine)
          repetition_capture
        elsif @language.aggregationHandler.get_aggregation(pLine)
          aggregation_capture
        else
          return
        end
      end

      # @see OOStructuredState
      def conditional_capture
        @language.set_state(@language.conditionalState)
      end

      # @see OOStructuredState
      def repetition_capture
        @language.set_state(@language.repetitionState)
      end

      # @see OOStructuredState
      def aggregation_capture
        @language.set_state(@language.aggregationState)
      end

      # @see OOStructuredState
      def method_capture
        reset_flag
        @language.rewind_state
      end

      # @see OOStructuredState
      def constructor_capture
        reset_flag
        @language.rewind_state
      end

      # @see OOStructuredState
      def function_capture
        reset_flag
        @language.rewind_state
      end

      # @see OOStructuredState
      def execute(pElementFile, pLine)
        conditional = @language.conditionalHandler.get_conditional(pLine)
        flag = @language.flagFunctionBehaviour

        if(conditional)
          get_add_conditional_lambda(MAP_STATE[flag]).call(conditional,
            pElementFile)
        end

        has_end_of_block = @language.endBlockHandler.has_end_of_block?(pLine)
        if(has_end_of_block)
          get_capture_lambda(MAP_STATE[flag]).call(has_end_of_block)
        end

        return pElementFile

      end

      private

        # @see OOStructuredState
        def reset_flag
          return if @language.previousState[-1].is_a? StateMachine::OOStructuredFSM::ConditionalState
          return if @language.previousState[-1].is_a? StateMachine::OOStructuredFSM::RepetitionState
          return if @language.previousState[-1].is_a? StateMachine::OOStructuredFSM::AggregationState

          @language.flagFunctionBehaviour = StateMachine::NONE_HANDLING_STATE
        end

        def get_add_conditional_lambda(lambdaType)
          add_conditional_lambda = lambda do |conditional, pElementFile|
            element = get_list_of_file(pElementFile, lambdaType).last
            element.add_conditional(conditional) if conditional
          end

          add_conditional_lambda
        end

        def get_list_of_file(pElementFile, pElementType)
          if pElementType == MAP_STATE[StateMachine::GLOBAL_FUNCTION_STATE]
            return pElementFile.global_functions
          else
            return pElementFile.classes.last.send("#{pElementType}s")
          end
        end

        def get_capture_lambda(pLambdaType)
          capture_lambda = lambda do |has_end_of_block|
          self.send("#{pLambdaType}_capture") if has_end_of_block
          end

          return capture_lambda
        end
    # End class
    end

  # End OOStructuredFSM
  end

# End StateMachine
end
