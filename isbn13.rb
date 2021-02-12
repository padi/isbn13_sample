# frozen_string_literal: true

class ISBN13
  attr_accessor :number, :digits

  class InvalidLength < StandardError; end

  def initialize(number)
    @number = number.freeze
    @digits = @number.digits.reverse.freeze

    raise InvalidLength if @digits.length != 13
  end

  # The expected check digit based on the entered 13-digit combination.
  # Checked against the calculated check digit
  def expected_check_digit
    digits.last
  end

  # The calculated check digit checked against the last ISBN13 digit
  def calculate_check_digit
    sum = digits.first(12).each_with_index.sum do |digit, index|
      index.even? ? digit : (digit * 3)
    end
    remainder = sum % 10
    remainder.zero? ? remainder : (10 - remainder)
  end

  def check_digit_valid?
    expected_check_digit == calculate_check_digit
  end
end
