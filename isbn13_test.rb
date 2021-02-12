require 'minitest/autorun'
require_relative 'isbn13'

class ISBN13Test < Minitest::Test
  def test_expected_check_digit
    assert_equal 2, ISBN13.new(9781861972712).expected_check_digit
  end

  def test_calculate_check_digit
    assert_equal 2, ISBN13.new(9781861972712).calculate_check_digit
  end

  def test_invalid_isbn13
    assert_raises(ISBN13::InvalidLength) { ISBN13.new(1234567890) }
  end
end
