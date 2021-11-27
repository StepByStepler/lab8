# frozen_string_literal: true

# Main controller
class PalindromesController < ApplicationController
  def input; end

  def view
    n = params[:n].to_i
    nums = find_nums n
    @result = nums.map { |num| { num: num, sqr: num * num } }
  end

  def dump
    respond_to do |format|
      format.all { render xml: PalindromeResult.all.map(&:attributes) }
    end
  end

  def palindrome?(num)
    num.to_s == num.to_s.reverse
  end

  private

  def find_nums(max)
    if (cached_result = PalindromeResult.find_by_max max)
      nums = ActiveSupport::JSON.decode cached_result.result
    else
      nums = (0..max).filter { |num| palindrome?(num) && palindrome?(num * num) }
      PalindromeResult.create max: max, result: ActiveSupport::JSON.encode(nums)
    end
    nums
  end
end
