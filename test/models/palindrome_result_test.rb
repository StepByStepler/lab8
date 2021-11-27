require 'test_helper'

class PalindromeResultTest < ActiveSupport::TestCase
  test 'should check uniqueness of objects by input' do
    res1 = PalindromeResult.new max: 25, result: [0, 1, 2, 3, 11, 12]
    assert res1.save
    res2 = PalindromeResult.new max: 25, result: [0, 1, 2, 3, 11, 12, 150]
    assert_not res2.save
  end
end
