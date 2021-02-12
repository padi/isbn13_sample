# frozen_string_literal: true

class ISBN13
  attr_accessor :number, :digits

  class InvalidLength < StandardError; end

  def initialize(number, debug=false)
    @number = number.freeze
    @digits = @number.digits.reverse.freeze
    @debug = debug

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
      if index.even? # 1st 3rd 5th ... 11th digit
        log "Adding (#{digit} * 1)"
        digit
      else           # 2nd 4th 6th ... 12th digit
        log "Adding (#{digit} * 3)"
        digit * 3
      end
    end
    log "sum is #{sum}"

    remainder = sum % 10
    log "remainder is #{remainder}"

    check_digit = if remainder == 0
      remainder
    else
      10 - remainder
    end
    log "check_digit is #{check_digit}"

    check_digit
  end

  def check_digit_valid?
    self.expected_check_digit == self.calculate_check_digit
  end

  def log *args
    puts *args if @debug
  end
end
