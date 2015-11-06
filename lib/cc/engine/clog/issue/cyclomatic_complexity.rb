require 'cc/engine/clog/issue/base'

module CC
  module Engine
    module Clog
      module Issue
        class CyclomaticComplexity < Base
          def initialize(path:, length:, from:, to:)
            @path = path
            @length = length
            @from = from
            @to = to
          end

          def to_json
            options = {
              check_name: 'Cyclomatic complexity',
              description: 'High cyclomatic complexity.',
              content: content,
              remediation_points: @length,
              location: {
                path: @path,
                lines: {
                  begin: @from,
                  end: @to
                }
              }
            }
            super(options)
          end

          private

          def content
            <<-CONTENT.gsub(/^ {12}/, '')
            Cyclomatic complexity analyses all possible execution scenarios of your code.
            Conditional operators increase the number of paths a program can run through your code.
            The more execution scenarios your code has, the harder it is to keep track of what is going on.
            That leads to misunderstanding and therefore to hacks and buggy implementations.

            #### Solutions

            * Avoid nested loops and conditionals.
            * Split up functionality into separate functions.

            #### Further Reading

            * ["Cyclomatic complexity"](https://en.wikipedia.org/wiki/Cyclomatic_complexity) - wikipedia
            * ["Cyclomatic complexity refactoring tips for javascript developers"](http://webuniverse.io/cyclomatic-complexity-refactoring-tips/) - Sergey Zarouski
            CONTENT
          end
        end
      end
    end
  end
end
