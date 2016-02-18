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

          out_file = Tempfile.new('out')
          err_file = Tempfile.new('err')

          if system(command, chdir: @directory, out: [out_file, 'a'], err: [err_file, 'a'])
            parse_output(File.read(out_file))
          else
            handle_error(File.read(err_file))
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
          if err =~ 'SyntaxError'
            abort 'Clog cannot analyze your code due to a syntax error in one of your coffee files.'
          else
            abort "Clog command failed #{err} in #{@directory} with command #{command}"
          end
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
