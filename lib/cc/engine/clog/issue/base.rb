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
                path: path,
                lines: {
                  begin: 1,
                  end: 1
                }
              }
            }

            JSON.generate(defaults.merge(options))
          end

          private

          def path
            @path.gsub(%r{^\./}, '')
          end
        end
      end
    end
  end
end
