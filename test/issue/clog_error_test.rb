require 'minitest_helper'
require 'json'

require 'cc/engine/clog/issue/clog_error'

module CC
  module Engine
    module Clog
      class ClogErrorIssueTest < Minitest::Test
        describe 'Issue::ClogError' do
          let(:issue) { Issue::ClogError.new(path: 'path', error: 'SyntaxError') }

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
            it 'has category Bug Risk' do
              assert_equal ['Bug Risk'], issue_json['categories']
            end
            it 'sets path as location path' do
              assert_equal 'path', issue_json['location']['path']
            end
            it 'calculates remediation points' do
              assert_equal 50_000, issue_json['remediation_points']
            end
          end
        end
      end
    end
  end
end
