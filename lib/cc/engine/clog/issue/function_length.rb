require 'cc/engine/clog/issue/base'

module CC
  module Engine
    module Clog
      module Issue
        class FunctionLength < Base
          def initialize(path:, length:, from:, to:)
            @path = path
            @length = length
            @from = from
            @to = to
          end

          def to_json
            options = {
              check_name: 'Function length',
              description: 'Large number of lines of code in function.',
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
            Keep your functions short. Smaller functions are easier to read and understand.
            An important side effect is, that they're also easier to test.
            A good function fits on a slide that the people in the last row of a big room can comfortably read.
            So don't count on them having perfect vision and limit yourself to 10-15 lines of code per function.

            #### Solutions

            * Extract functionality into separate modules.
            * Extract blocks of logic small private methods where possible.

            #### Further Reading

            * ["Functions Should Be Short And Sweet, But Why?"](http://sam-koblenski.blogspot.ch/2014/01/functions-should-be-short-and-sweet-but.html) - Sam Koblenski
            * ["Code smells: Long method"](https://sourcemaking.com/refactoring/smells/long-method) - sourceMaking
            * ["Extract method"](https://sourcemaking.com/refactoring/extract-method) - sourceMaking
            * ["Replace method with method object"](https://sourcemaking.com/refactoring/replace-method-with-method-object) - sourceMaking
            CONTENT
          end
        end
      end
    end
  end
end
