require 'test_helper'

class PalindromesControllerTest < ActionDispatch::IntegrationTest
  test 'should get input' do
    get palindromes_input_url
    assert_response :success
  end

  test 'should get view' do
    get palindromes_view_url
    assert_response :success
  end

  test 'should return proper nums for simple input' do
    get palindromes_view_url, params: { n: 25 }
    assert_equal [0, 1, 2, 3, 11, 22], assigns[:result]
  end

  test 'should return empty array for negative input' do
    get palindromes_view_url, params: { n: -5 }
    assert_empty assigns[:result]
  end
end
