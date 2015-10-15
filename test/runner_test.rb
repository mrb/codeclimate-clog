require 'minitest_helper'

require 'cc/engine/clog/runner'

module CC
  module Engine
    module Clog
      class RunnerTest < Minitest::Test
        describe 'Runner' do
          let(:mock_io) { Minitest::Mock.new }
          let(:issue_json) { Issue.new(path: 'path', complexity: 5).to_json }

          describe 'call' do
            it 'runs command without failing' do
              Runner.new(directory: 'test/fixtures/included_files', io: mock_io).call
            end
          end

          describe 'check_result' do
            it 'reports issue json to console if complexity is > 100' do
              mock_io.expect :puts, issue_json, [String]
              r = Runner.new(directory: 'path', io: mock_io)
              r.check_result('path', 'complexity' => 101)

              assert mock_io.verify
            end
            it 'does not report issue json to console if complexity is < 100' do
              assert_raises MockExpectationError do
                mock_io.expect :puts, issue_json, [String]
                r = Runner.new(directory: 'path', io: mock_io)
                r.check_result('path', 'complexity' => 99)
                mock_io.verify
              end
            end
          end
        end
      end
    end
  end
end
