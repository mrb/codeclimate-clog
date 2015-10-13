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
                        check_name: 'Overall complexity',
                        description: 'High overall complexity reported by clog.',
                        categories: ['Complexity'],
                        location: @path,
                        remediation_points: @complexity)
        end
      end
    end
  end
end
