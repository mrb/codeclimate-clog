require 'tempfile'

require 'json'
require 'open3'
require 'cc/engine/clog/path_filter'
require 'cc/engine/clog/output_interpreter'

module CC
  module Engine
    module Clog
      class Runner
        def initialize(directory:, engine_config: {}, io:)
          @directory = directory
          @include_paths = engine_config['include_paths']
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
            output_interpreter = OutputInterpreter.new(path, result).call
            output_interpreter.issues.each { |issue| report_issue(issue) }
          end
        end

        def handle_error(err)
          abort "Clog command failed #{err} - #{@directory} - #{command}"
        end

        def report_issue(issue)
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
