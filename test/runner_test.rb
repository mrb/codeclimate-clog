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
              mock_io.expects(:puts).with(includes('issue')).at_least(1)
              Runner.new(directory: '.', io: mock_io, engine_config: { 'include_paths' => ['test/fixtures/script/'] }).call
            end

            it 'analyses the files' do
              mock_io.expects(:puts).with(includes('CocoClass.coffee')).at_least(1)
              Runner.new(directory: '.', io: mock_io, engine_config: { 'include_paths' => ['test/fixtures/script/'] }).call
            end

            it 'raises when command fails' do
              assert_raises SystemExit do
                Runner.new(directory: '.', io: mock_io, engine_config: { 'include_paths' => ['test/fixtures/inexistent/'] }).call
              end
            end

            describe 'analysers' do
              before do
                mock_io.stubs(:puts)
              end

              it 'include Token complexity' do
                mock_io.expects(:puts).with(includes('Token complexity'))
                Runner.new(directory: '.', io: mock_io, engine_config: { 'include_paths' => ['test/fixtures/script/'] }).call
              end

              it 'include Cyclomatic complexity' do
                mock_io.expects(:puts).with(includes('Cyclomatic complexity'))
                Runner.new(directory: '.', io: mock_io, engine_config: { 'include_paths' => ['test/fixtures/script/'] }).call
              end

              it 'include File length' do
                mock_io.expects(:puts).with(includes('File length'))
                Runner.new(directory: '.', io: mock_io, engine_config: { 'include_paths' => ['test/fixtures/script/'] }).call
              end

              it 'include Function length' do
                mock_io.expects(:puts).with(includes('Function length'))
                Runner.new(directory: '.', io: mock_io, engine_config: { 'include_paths' => ['test/fixtures/script/'] }).call
              end
            end
          end
        end
      end
    end
  end
end
