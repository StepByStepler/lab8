require 'application_system_test_case'

class PalindromesTest < ApplicationSystemTestCase
  setup do
    @driver = Capybara.current_session.driver.browser
  end

  test 'check that palindrome app works via selenium' do
    @driver.navigate.to palindromes_input_url
    @driver.find_element(name: 'n').send_keys '25'
    @driver.find_element(name: 'n').submit
    Selenium::WebDriver::Wait.new.until { @driver.find_element(name: 'res-table') }

    actual_nums = @driver.find_elements(css: 'div[name="res-table"] > div > div:nth-child(2)')
                        .drop(1)
                        .map { |div| div.text.to_i }
    assert_equal [0, 1, 2, 3, 11, 22], actual_nums
  end
end
