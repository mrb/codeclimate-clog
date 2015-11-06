require 'cc/engine/clog/issue/base'

module CC
  module Engine
    module Clog
      module Issue
        class FileLength < Base
          def initialize(path:, length:)
            @path = path
            @length = length
          end

          def to_json
            options = {
              check_name: 'Lines of code',
              description: 'Huge number of lines of code in file.',
              content: content,
              remediation_points: @length
            }
            super(options)
          end

          private

          def content
            <<-CONTENT.gsub(/^ {12}/, '')
            Files usually start small. But over time, they get bloated as the program grows.
            As is the case with long methods as well, programmers usually find it mentally less taxing to place a new feature in an existing class than to create a new class for the feature.
            Keep your files short. Shorter files are easier to read, understand and navigate.

            #### Solutions

            * Have only one module/class per file.
            * Follow the single responsibility pattern.
            * Extract functionality into separate modules/classes.

            #### Further Reading
            * ["Code smells: Large class"](https://sourcemaking.com/refactoring/smells/large-class) - sourceMaking
            * ["Functions Should Be Short And Sweet, But Why?"](http://sam-koblenski.blogspot.ch/2014/01/functions-should-be-short-and-sweet-but.html) - Sam Koblenski
            * ["The Single Responsibility Principle"](http://programmer.97things.oreilly.com/wiki/index.php/The_Single_Responsibility_Principle) - Robert C. Martin
            * ["Extract Class"](https://sourcemaking.com/refactoring/extract-class) - sourceMaking
            * ["Extract Subclass"](https://sourcemaking.com/refactoring/extract-subclass) - sourceMaking
            CONTENT
          end
        end
      end
    end
  end
end
