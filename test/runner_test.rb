require 'minitest_helper'
require 'mocha/mini_test'

require 'cc/engine/clog/runner'

module CC
  module Engine
    module Clog
      class RunnerTest < Minitest::Test
        describe 'Runner' do
          let(:mock_io) { mock }

          describe 'call' do
            it 'outputs the results' do
              mock_io.expects(:puts).with(includes('issue'))
              Runner.new(directory: '.', io: mock_io, engine_config: { 'include_paths' => ['test/fixtures/script/'] }).call
            end

            it 'raises when command fails' do
              assert_raises SystemExit do
                Runner.new(directory: '.', io: mock_io, engine_config: { 'include_paths' => ['test/fixtures/inexistent/'] }).call
              end
            end
          end
        end
      end
    end
  end
end
