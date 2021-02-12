# frozen_string_literal: true

class ISBN13
  attr_accessor :number, :digits

  class InvalidLength < StandardError; end

  def initialize(number, debug=true)
    @number = number.freeze
    @digits = @number.digits.freeze
    @debug = debug

    raise InvalidLength if @digits.length != 13
  end

  def expected_check_digit
    digits.first
  end

  def first_12_digits
    first_12_digits = digits.drop(1).reverse
  end

  def calculate_check_digit
    sum = first_12_digits.each_with_index.sum do |digit, index|
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

  def log *args
    puts *args if @debug
  end
end
