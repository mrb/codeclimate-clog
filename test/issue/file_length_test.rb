require 'minitest_helper'
require 'json'

module CC
  module Engine
    module Clog
      class FileLengthIssueTest < Minitest::Test
        describe 'Issue::FileLength' do
          let(:issue) { Issue::FileLength.new(path: 'path', length: 900) }

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
            it 'has a content' do
              refute_nil issue_json['content']
            end
            it 'has category Complexity' do
              assert_equal ['Complexity'], issue_json['categories']
            end
            it 'sets path as location path' do
              assert_equal 'path', issue_json['location']['path']
            end
            it 'sets length as remediation_points' do
              assert_equal 900, issue_json['remediation_points']
            end
          end
        end
      end
    end
  end
end
