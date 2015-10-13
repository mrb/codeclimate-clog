require 'json'
require 'open3'
require 'cc/engine/clog/issue'

module CC
  module Engine
    module Clog
      class Runner
        def initialize(directory:, engine_config:{}, io:)
          @directory = directory
          @include_paths = engine_config['include_paths'] || ['.']
          @complexity_threshold = engine_config['complexity_threshold'] || 200
          @io = io

          STDERR.puts "Engine config: #{engine_config}"
          STDERR.puts "Command: #{command}"
        end

        def call
          _stdin, stdout, stderr = Open3.popen3(command)
          if (err = stderr.gets)
            fail err
          elsif (output = stdout.gets)
            JSON.parse(output).each do |path, result|
              check_result(path, result)
            end
          end
        end

        private

        def check_result(path, result)
          complexity = result['complexity']
          return unless complexity > @complexity_threshold

          issue = Issue.new(path: path, complexity: complexity)
          @io.puts issue.to_json
        end

        def command
          "cd #{@directory} && /Users/cfelder/.nvm/v0.10.40/bin/clog #{@include_paths.join(' ')}"
        end
      end
    end
  end
end
