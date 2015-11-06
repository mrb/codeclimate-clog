require 'json'

module CC
  module Engine
    module Clog
      module Issue
        class Base
          def to_json(options = {})
            defaults = {
              type: 'issue',
              categories: ['Complexity'],
              location: {
                path: @path
              }
            }

            JSON.generate(defaults.merge(options))
          end
        end
      end
    end
  end
end
