require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get sessions_new_url
    assert_response :success
  end

  test 'should handle register properly' do
    assert_nil User.find_by_name('test_user')
    post users_url, params: { user: { name: 'test_user', password: 'secret', password_confirmation: 'secret' } }
    assert_not_nil User.find_by_name('test_user')
    assert_redirected_to palindromes_input_url
  end

  test 'should handle login properly' do
    get sessions_create_url, params: { username: 'user1', password: 'secret' }
    assert_response :ok
    get palindromes_input_url
    assert_response :ok

    get palindromes_view_url, params: { n: 25 }
    assert_select 'div#num-col' do |elements|
      actual_nums = elements.map { |element| element.text.to_i }
      assert_equal [0, 1, 2, 3, 11, 22], actual_nums
    end
  end

  test 'should forbid logging in with incorrect credentials' do
    get sessions_create_url, params: { username: 'user1', password: 'wrong_password' }
    assert_response :unauthorized
  end

  test 'should forbid computation without login' do
    get palindromes_input_url
    assert_redirected_to sessions_new_url
  end
end
