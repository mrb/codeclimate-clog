module CC
  module Engine
    module Clog
      class AnalyzableFiles
        def initialize(include_paths)
          @paths = include_paths
        end

        def all
          filter_paths.empty? ? ['.'] : filter_paths
        end

        private

        def filter_paths
          return [] unless @paths
          @paths.map do |path|
            if folder?(path)
              Dir.glob("#{path}**/*.coffee")
            else
              path if path =~ /\.coffee$/
            end
          end.flatten.compact
        end

        def folder?(path)
          path =~ %r{/$}
        end
      end
    end
  end
end
