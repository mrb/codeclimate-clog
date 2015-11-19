require 'cc/engine/clog/issue/base'

module CC
  module Engine
    module Clog
      module Issue
        class TokenComplexity < Base
          THRESHOLD = 100
          REMEDIATION_FACTOR = 50_000

          def initialize(path:, score:)
            @path = path
            @score = score.round
          end

          def to_json
            options = {
              check_name: 'Token complexity',
              description: "High overall token complexity (#{@score}/#{THRESHOLD})",
              content: { body: content},
              remediation_points: remediation_points,
              location: {
                path: @path,
                lines: {
                  begin: 1,
                  end: 1
                }
              }
            }
            super(options)
          end

          def remediation_points
            (@score - THRESHOLD) * REMEDIATION_FACTOR
          end

          private

          def content
            <<-CONTENT.gsub(/^ {12}/, '')
            Some coffeescript language constructs can lead to complex and hard to read code.
            Watch out for the following constructs, that are sorted by ascending penalties:

            * `.` - Many methods called, long method chaining or accessing deeply nested objects. Can be hard to read.
            * `[]` - Accessing deep multi dimensional arrays can be hard to understand.
            * `{}` - Defining deeply nested objects that are complex to work with.
            * function parameters - Passing too many parameters to functions can be hard to read. Pass parameter objects instead.
            * `=>` - The fat arrow changes the scope of `this`, which can be hard to grasp.
            * `?.` - Handling `null/undefined` implies complex logic.
            * `if/else/switch` - Conditionals result in multiple paths through your code that need to be tested.
            * `null` - Handling `null/undefined` implies complex logic. If you have to, favor the use of the existential operator.
            * Regex - Often times a source of headache for many developers.
            * `for/for in/for of` - Favor `forEach` over complex loops.
            * `super` - Used when overwriting logic in super class, which might be hard to follow.
            * `extends` - Hiding away logic in a super class, which might be hard to follow.


            #### Further Reading

            * [Your code sucks, let’s fix it (Video)](https://www.youtube.com/watch?v=GtB5DAfOWMQ) — Rafael Dohms
            * [Idiomatic Coffeescript](https://github.com/mkautzmann/Idiomatic-CoffeeScript) - Matheus Kautzmann
            * [Callback Hell](http://callbackhell.com/) - Max Ogden
            CONTENT
          end
        end
      end
    end
  end
end
