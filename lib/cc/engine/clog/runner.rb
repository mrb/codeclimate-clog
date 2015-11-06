require 'tempfile'

require 'json'
require 'open3'
require 'cc/engine/clog/issue'
require 'cc/engine/clog/path_filter'

module CC
  module Engine
    module Clog
      class Runner
        def initialize(directory:, engine_config: {}, io:)
          @directory = directory
          @include_paths = engine_config['include_paths']
          @token_complexity_threshold = engine_config['token_complexity_threshold'] || 50
          @io = io
        end

        def call
          return if included_files.empty?

          stdout = Tempfile.new('out')
          stderr = Tempfile.new('err')

          success = system(command, chdir: @directory, out: [stdout, 'a'], err: [stderr, 'a'])
          if success
            parse_output(File.read(stdout))
          else
            handle_error(File.read(stderr))
          end
        end

        private

        def parse_output(out)
          JSON.parse(out).each do |path, result|
            check_result(path, result)
          end
        end

        def handle_error(err)
          abort "Clog command failed #{err} - #{@directory} - #{command}"
        end

        def check_result(path, result)
          token_complexity = result['tokenComplexity'] || 0
          return unless token_complexity > @token_complexity_threshold

          issue = Issue.new(path: path, complexity: token_complexity)
          @io.puts "#{issue.to_json}\0"
        end

        def command
          "clog #{included_files.join(' ')}"
        end

        def included_files
          PathFilter.new(@include_paths).call
        end
      end
    end
  end
end
