# Capybara View Helper

The Capybara View helper allows to use Capybara helpers and matchers in view or
[component](https://viewcomponent.org/guide/testing.html) specs. With most of
the Capybara helper and matchers available in view specs, it's now possible to
pinpoint various HTML tags and CSS selectors just as in system and feature specs.

The helper includes support for Capybara finders, matchers and `within` and
`within_element` methods.

## Requirements

* [Capybara](https://github.com/teamcapybara/capybara)

## Usage

### RSpec

1. Copy the snippet and paste it in a new file in the `spec/support` directory
1. Make sure the file is required (either automatically or manually) in the
    `rails_helper` file
1. Include `CapybaraViewHelper` in the view and component specs:

    ```ruby
    RSpec.configure do |config|
      config.include CapybaraViewHelper, type: :view
      config.include CapybaraViewHelper, type: :component
    end
    ```
