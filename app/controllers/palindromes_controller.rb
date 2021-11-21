# frozen_string_literal: true

# Main controller
class PalindromesController < ApplicationController
  def input; end

  def view
    n = params[:n].to_i
    @result = (0..n).filter { |num| palindrome?(num) && palindrome?(num * num) }
  end

  def palindrome?(num)
    num.to_s == num.to_s.reverse
  end
end
