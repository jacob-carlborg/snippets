# Selenium Throttler

The Selenium Throttler allows to run tests which are using Selenium at a lower
speed. This makes it easier to follow along with the tests when debugging since
they will otherwise be too fast for a human.

## Requirements

* Ruby 2.7 or later
* Selenium

## Usage

Copy the snippet and paste it into your testing framework's main file. For RSpec
this is the `spec/spec_helper.rb` file.

To throttle Selenium, set the `SELENIUM_THROTTLING` environment variable. This
will run the tests at 50% speed. If the value of `SELENIUM_THROTTLING` is a
numeric value it will be used as the throttling factor. If
`SELENIUM_THROTTLING` is set to `0.1` it will throttle the tests by 10%, that
is, it will run the tests at 90% speed.
