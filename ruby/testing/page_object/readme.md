# Page Object

The [page object pattern](https://martinfowler.com/bliki/PageObject.html)
isolates tests from the exact structure of the HTML of the pages it operates
on. It's intended to provide an application-specific API, allowing to
manipulate page elements without digging around in the HTML.

For each page or specific part of a page that a test needs to operate on,
create a subclass of the `BasePage` class in the snippet and implement the
application-specific API.

## Requirements

* [Capybara](https://github.com/teamcapybara/capybara)

## Usage

The snippet is just an example of how the page object pattern can be implemented.
The `BasePage` class can be copied as is.

1. Copy the `BasePage` class from the snippet and paste it into a new file in
    the `rspec/support` directory.
1. Copy the `Example::NewPage` class from the snippet and paste it into a new
    file in the `rspec/support`
1. Rename and adopt the `Example::NewPage` to suit your needs
1. Require the files where needed
1. In the tests, instantiate the page object and pass in an instance of
    `Capybara::Session`. This is usually the method named `page`

    ```ruby
    RSpec.feature "Example", type: :system do
      let(:new_page) { Example::NewPage.new(page) }
      let(:valid_attributes) { { foo: "TP123", bar: "Fast Logistics" } }

      scenario "creating a new example" do
        new_page.visit
        new_page.form.fill_in(with: valid_attributes)
        new_page.form.submit
      end
    end
    ```
