# Full Page Screenshot

The Full Page Screenshot helper takes a screenshot of the whole page, even if
some content is not visible and needs to be scrolled.

## Requirements

* [Ruby on Rails](https://rubyonrails.org)
* [Capybara](https://github.com/teamcapybara/capybara)
* [Selenium WebDriver](https://www.selenium.dev)

## Usage

Copy the snippet and paste it into your testing framework's main file. For RSpec
this is the `spec/spec_helper.rb` file. The helper will automatically hook into
the testing framework and a full page screenshot will automatically be created
when a test fails.
