require 'json'
require 'open3'
require 'cc/engine/clog/issue'
require 'cc/engine/clog/analyzable_files'

module CC
  module Engine
    module Clog
      class Runner
        def initialize(directory:, engine_config:{}, io:)
          @directory = directory
          @include_paths = engine_config['include_paths']
          @complexity_threshold = engine_config['complexity_threshold'] || 100
          @io = io
        end

        def call
          _stdin, stdout, stderr = Open3.popen3(command)
          if (err = stderr.gets)
            raise(err)
          elsif (output = stdout.gets)
            JSON.parse(output).each do |path, result|
              check_result(path, result)
            end
          end
        end

        def check_result(path, result)
          complexity = result['complexity']
          return unless complexity > @complexity_threshold

          issue = Issue.new(path: path, complexity: complexity)
          @io.puts issue.to_json
        end

        private

        def command
          "cd #{@directory} && clog #{included_files.join(' ')}"
        end

        def included_files
          AnalyzableFiles.new(@include_paths).all
        end
      end
    end
  end
end
