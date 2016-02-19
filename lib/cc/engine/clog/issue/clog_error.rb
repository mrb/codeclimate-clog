require 'cc/engine/clog/issue/base'

module CC
  module Engine
    module Clog
      module Issue
        class ClogError < Base
          REMEDIATION_POINTS = 50_000

          def initialize(path:, error:)
            @path = path
            @error = error
          end

          def to_json
            options = {
              categories: ['Bug Risk'],
              check_name: 'Clog error',
              description: "Clog encountered an error analyzing the file: #{@error}",
              remediation_points: REMEDIATION_POINTS,
              location: {
                path: path,
                lines: {
                  begin: 1,
                  end: 1
                }
              }
            }
            super(options)
          end
        end
      end
    end
  end
end
