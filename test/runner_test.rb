require 'minitest_helper'
require 'mocha/mini_test'

require 'cc/engine/clog/runner'

module CC
  module Engine
    module Clog
      class RunnerTest < Minitest::Test
        describe 'Runner' do
          let(:mock_io) { mock }
          let(:complex_output) { '{"./coffeescript.coffee":{"gpa":2.25,"churn":0,"complexity":110,"tokenCount":63},"./test/fixtures/included_files/coffeescript.coffee":{"gpa":0,"churn":1,"complexity":0,"tokenCount":0}}' }
          let(:easy_output) { '{"./coffeescript.coffee":{"gpa":4.25,"churn":0,"complexity":90,"tokenCount":63},"./test/fixtures/included_files/coffeescript.coffee":{"gpa":0,"churn":1,"complexity":0,"tokenCount":0}}' }

          describe 'call' do
            it 'raises when command fails' do
              popen_return = [stub(gets: nil), stub(gets: nil), stub(gets: 'err')]
              Open3.expects(:popen3).returns(popen_return)
              assert_raises SystemExit do
                Runner.new(directory: 'test/fixtures/included_files', io: mock_io).call
              end
            end
            it 'reports issue json to console if complexity is > 100' do
              popen_return = [stub(gets: nil), stub(gets: complex_output), stub(gets: nil)]
              Open3.expects(:popen3).returns(popen_return)

              mock_io.expects(:puts)
              Runner.new(directory: 'test/fixtures/included_files', io: mock_io).call
            end
            it 'does not report issue json to console if complexity is < 100' do
              popen_return = [stub(gets: nil), stub(gets: easy_output), stub(gets: nil)]
              Open3.expects(:popen3).returns(popen_return)

              mock_io.expects(:puts).never
              Runner.new(directory: 'test/fixtures/included_files', io: mock_io).call
            end
          end
        end
      end
    end
  end
end
