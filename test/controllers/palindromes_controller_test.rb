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
      actual_nums = elements.map { |element| element.text.to_i }
      assert_equal [0, 1, 2, 3, 11, 22], actual_nums
    end
  end

  test 'should return empty array for negative input' do
    get palindromes_view_url, params: { n: -5 }
    assert_select 'p#no-number-msg'
  end

  test 'should open page' do
    Selenium::WebDriver::Chrome::Service.driver_path = "#{Rails.root.to_s}/chromedriver.exe"
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to 'http://localhost:3000/palindromes/input'
    element = driver.find_element(name: 'n')
    element.send_keys '25'
    element.submit
    Selenium::WebDriver::Wait.new.until { driver.find_element(name: 'res-table') }

    actual_nums = driver.find_elements(css: 'div[name="res-table"] > div > div:nth-child(2)')
                        .drop(1)
                        .map { |div| div.text.to_i }
    assert_equal [0, 1, 2, 3, 11, 22], actual_nums
  end
end
