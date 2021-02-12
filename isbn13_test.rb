# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'isbn13'

class ISBN13Test < Minitest::Test
  def test_expected_check_digit
    # Example taken from https://isbn-information.com/check-digit-for-the-13-digit-isbn.html
    assert_equal 2, ISBN13.new(9781861972712).expected_check_digit

    # Generated ISBN13 codes from https://fungenerators.com/random/barcode/isbn13
    assert_equal 1, ISBN13.new(9795388861831).expected_check_digit
    assert_equal 2, ISBN13.new(9783600125472).expected_check_digit
    assert_equal 7, ISBN13.new(9780504954917).expected_check_digit
  end

  def test_calculate_check_digit
    # Example taken from https://isbn-information.com/check-digit-for-the-13-digit-isbn.html
    assert_equal 2, ISBN13.new(9781861972712).calculate_check_digit

    # Generated ISBN13 codes from https://fungenerators.com/random/barcode/isbn13
    assert_equal 1, ISBN13.new(9795388861831).calculate_check_digit
    assert_equal 2, ISBN13.new(9783600125472).calculate_check_digit
    assert_equal 7, ISBN13.new(9780504954917).calculate_check_digit
  end

  def test_check_digit_valid?
    # Example taken from https://isbn-information.com/check-digit-for-the-13-digit-isbn.html
    assert ISBN13.new(9781861972712).check_digit_valid?
    # 5th and 6th digits accidentally via manually entering
    refute ISBN13.new(9781681972712).check_digit_valid?
    # tenth digit has been read by scanner as a three rather than as a two
    refute ISBN13.new(9781861973712).check_digit_valid?

    # Generated ISBN13 codes from https://fungenerators.com/random/barcode/isbn13
    assert ISBN13.new(9795388861831).check_digit_valid?
    assert ISBN13.new(9783600125472).check_digit_valid?
    assert ISBN13.new(9780504954917).check_digit_valid?

    # Test for special case: check digit is 0
    assert ISBN13.new(9794059264780).check_digit_valid?
  end

  def test_invalid_length
    assert_raises(ISBN13::InvalidLength) { ISBN13.new(1234567890) }
  end
end
