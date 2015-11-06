require 'json'

module CC
  module Engine
    module Clog
      class Issue
        def initialize(path:, complexity:)
          @path = path
          @complexity = complexity
        end

        def to_json
          JSON.generate(type: 'issue',
                        check_name: 'Token complexity',
                        description: 'High overall token complexity.',
                        content: content,
                        categories: ['Complexity'],
                        location: {
                          path: @path
                        },
                        remediation_points: @complexity)
        end

        private

        def content
          <<-CONTENT.gsub(/^ {10}/, '')
          Clog assesses code complexity by analyzing tokens from the coffeescript lexer. Tokens include operators (eg. +, =, --), control structures (eg. for, if, switch) and various other constructs. In general, few tokens per file are favored over many. Tokens that lead to complex code have a higher penalty than basic ones.

          Functions with high complexity are harder to test and understand, leading to bugs and higher maintenance costs. Refactor at will.

          #### Solutions

          * Extract functionality into separate modules.
          * Avoid nested / complex loops and conditionals.
          * Keep your code shallow, avoid ending up in callback hell.
          * Extract blocks of logic small private methods where possible.

          #### Further Reading

          * [SOLID: Part 1 - The Single Responsibility Principle](http://code.tutsplus.com/tutorials/solid-part-1-the-single-responsibility-principle--net-36074)
          * ["Clean Code: A Handbook of Agile Software Craftsmanship"](http://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882) - Robert C. Martin
          * ["Refactoring: Improving the Design of Existing Code"](http://www.amazon.com/gp/product/0201485672/) - Martin Fowler et. al.
          * ["The Single Responsibility Principle"](http://programmer.97things.oreilly.com/wiki/index.php/The_Single_Responsibility_Principle) - Robert C. Martin
          * [Your code sucks, let’s fix it (Video)](https://www.youtube.com/watch?v=GtB5DAfOWMQ) — Rafael Dohms
          * [Idiomatic Coffeescript](https://github.com/mkautzmann/Idiomatic-CoffeeScript) - Matheus Kautzmann
          * [Callback Hell](http://callbackhell.com/) - Max Ogden
          CONTENT
        end
      end
    end
  end
end
