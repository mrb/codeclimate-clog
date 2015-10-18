module CC
  module Engine
    module Clog
      class PathFilter
        def initialize(include_paths)
          @paths = include_paths || []
        end

        def call
          @paths.select { |path| ends_with?(path, '/') || ends_with?(path, '.coffee') }
        end

        private

        def ends_with?(path, ending)
          path =~ /#{ending}$/
        end
      end
    end
  end
end
