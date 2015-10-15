require 'minitest_helper'

require 'cc/engine/clog/analyzable_files'

module CC
  module Engine
    module Clog
      class AnalyzableFilesTest < Minitest::Test
        describe 'AnalyzableFiles' do
          describe 'when passing folders' do
            it 'globs all coffee files in folder' do
              # fixtures_path = File.join(File.dirname(__FILE__), 'fixtures/included_files/')
              fixtures_path = 'test/fixtures/included_files/'
              af = AnalyzableFiles.new([fixtures_path])
              assert_equal ['test/fixtures/included_files/coffeescript.coffee'], af.all
            end
            it 'falls back to current directory' do
              af = AnalyzableFiles.new(['test/fixtures/other_files/'])
              assert_equal ['.'], af.all
            end
          end

          describe 'when passing files' do
            it 'only includes the ones with .coffee extension' do
              af = AnalyzableFiles.new(['coffeescript.coffee', 'ruby.rb'])
              assert_equal ['coffeescript.coffee'], af.all
            end
          end
        end
      end
    end
  end
end
