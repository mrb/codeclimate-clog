require 'minitest_helper'
require 'json'

require 'cc/engine/clog/issue'

module CC
  module Engine
    module Clog
      class IssueTest < Minitest::Test
        describe 'Issue' do
          let(:issue) { Issue.new(path: 'path', complexity: 5) }

          describe 'to_json' do
            let(:issue_json) { JSON.parse(issue.to_json) }

            it 'returns json' do
              assert_instance_of Hash, issue_json
            end
            it 'has type issue' do
              assert_equal 'issue', issue_json['type']
            end
            it 'has a check_name' do
              refute_nil issue_json['check_name']
            end
            it 'has a description' do
              refute_nil issue_json['description']
            end
            it 'has category Complexity' do
              assert_equal ['Complexity'], issue_json['categories']
            end
            it 'sets path as location path' do
              assert_equal 'path', issue_json['location']['path']
            end
            it 'sets complexity as emediation_points' do
              assert_equal 5, issue_json['remediation_points']
            end
          end
        end
      end
    end
  end
end
