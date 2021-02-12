# ISBN13

## Requirements

- Minitest (via `gem install minitest`)
- Ruby 2.7.1

## How to Use

```bash
$ git clone git clone https://github.com/padi/isbn13_sample.git
$ cd isbn13_sample
$ irb
irb(main):001:0> require_relative 'isbn13'
=> true
irb(main):002:0> isbn = ISBN13.new(9781861972712)
irb(main):003:0> isbn.calculate_check_digit
=> 2
irb(main):004:0> isbn.check_digit_valid?
=> true
```

## How to Test

```bash
$ gem install minitest # install minitest
$ ruby isbn13_test.rb

Run options: --seed 16934

# Running:

....

Finished in 0.001415s, 2826.8551 runs/s, 11307.4205 assertions/s.
4 runs, 16 assertions, 0 failures, 0 errors, 0 skips
```
