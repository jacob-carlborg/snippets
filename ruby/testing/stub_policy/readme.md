# Stub Policy

This snippet allows to stub a [Pundit](https://github.com/varvet/pundit) policy
which is used in a view. This is usually used in view in a Ruby on Rails
project.

## Requirements

* [Pundit](https://github.com/varvet/pundit)
* [RSpec](https://rspec.info)
* A method `view` which returns an object that responds to `policy`

## Usage

1. Copy the snippet and paste it into a new file.
1. Configure RSpec to include the module into relevant testing categories:

    ```ruby
    RSpec.configure do |config|
      config.include PunditViewHelper, type: :view
      config.include PunditViewHelper, type: :decorator
    end
    ```
1. If the view contains code like:

    ```erb
    <% if policy(:foo).edit? %>
      ...
    <% end %>
    ```

    This can be stubbed with:

    ```ruby
    describe "show" do
      it "show something" do
        stub_policy(action: :edit?, authorized: true)
      end
    end
    ```
