require 'minitest_helper'

require 'cc/engine/clog/path_filter'

module CC
  module Engine
    module Clog
      class PathFilterTest < Minitest::Test
        describe 'PathFilter' do
          describe 'call' do
            it 'only keeps coffee files' do
              af = PathFilter.new(['file.rb', 'file.coffee'])
              assert_equal ['file.coffee'], af.call
            end
            it 'keeps folders' do
              af = PathFilter.new(['folder/'])
              assert_equal ['folder/'], af.call
            end
          end
        end
      end
    end
  end
end
