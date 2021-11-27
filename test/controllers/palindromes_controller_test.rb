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
    assert_select 'div#num-col' do |elements|
      assert_equal 6, elements.size

      expected = [0, 1, 2, 3, 11, 22]
      elements.each_with_index do |element, index|
        assert_equal expected[index], element.text.to_i
      end
    end
  end

  test 'should return empty array for negative input' do
    get palindromes_view_url, params: { n: -5 }
    assert_select 'p#no-number-msg'
  end

  test 'should return valid nums for xml' do
    get '/palindromes/view.xml', params: { n: 25 }
    actual_nums = Nokogiri::XML(@response.body).xpath('//num').map { |node| node.text.to_i }
    assert_equal [0, 1, 2, 3, 11, 22], actual_nums
  end
end
