require 'cc/engine/clog/issue/clog_error'
require 'cc/engine/clog/issue/cyclomatic_complexity'
require 'cc/engine/clog/issue/file_length'
require 'cc/engine/clog/issue/function_length'
require 'cc/engine/clog/issue/token_complexity'

module CC
  module Engine
    module Clog
      class OutputInterpreter
        def initialize(path, result)
          @path = path
          @result = result
          @issues = []
        end

        attr_accessor :issues

        def call
          if @result['error']
            handle_error
          else
            handle_cyclomatic_complexity
            handle_file_length
            handle_function_length
            handle_token_complexity
          end
          self
        end

        private

        def handle_error
          issues << Issue::ClogError.new(path: @path, error: @result['error'])
        end

        def handle_cyclomatic_complexity
          lengths = @result['cyclomaticComplexity']['lines'].select { |_, score| score > Issue::CyclomaticComplexity::THRESHOLD }
          lengths.each do |line_range, score|
            from, to = parse_line_range(line_range)
            issues << Issue::CyclomaticComplexity.new(path: @path, score: score, from: from, to: to)
          end
        end

        def handle_file_length
          length = @result['functionLength']['total']
          return unless length > Issue::FileLength::THRESHOLD

          issues << Issue::FileLength.new(path: @path, length: length)
        end

        def handle_function_length
          lengths = @result['functionLength']['lines'].select { |_, length| length > Issue::FunctionLength::THRESHOLD }
          lengths.each do |line_range, length|
            from, to = parse_line_range(line_range)
            issues << Issue::FunctionLength.new(path: @path, length: length, from: from, to: to)
          end
        end

        def handle_token_complexity
          return if @result['tokenCount'] == 0

          score = @result['tokenComplexity'] / @result['tokenCount'] * 100
          return unless score > Issue::TokenComplexity::THRESHOLD

          issues << Issue::TokenComplexity.new(path: @path, score: score)
        end

        def parse_line_range(range)
          range.split('-')
        end
      end
    end
  end
end
