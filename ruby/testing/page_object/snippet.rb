# Implements the page object pattern.
#
# The page object pattern isolates tests from the exact structure of the HTML of
# the pages it operates on. It's intended to provide an application-specific API,
# allowing to manipulate page elements without digging around in the HTML.
#
# For each page or specific part of a page that a test needs to operate on,
# create a subclass of this class and implement the application-specific API.
class BasePage
  # @param page [Capybara::Session] the Capybara page
  def initialize(page)
    @page = page
  end

  # Recursively find elements.
  #
  # @example
  #   dig("foo", "bar") # same as page.find("foo").find("bar")
  #
  # @example Find elements with of an explicit format
  #   dig(:xpath, "foo", "bar") # page.find(:xpath, "foo").find(xpath, "bar")
  #
  # @param locators [Array<Symbol, String>] the locators to search for
  def dig(*locators)
    selector, locators = if Capybara::Selector.all[locators.first]
      [locators.first, locators.drop(1)]
    else
      [Capybara::Selector[Capybara.default_selector], locators]
    end

    locators.reduce(page) { |page, locator| page.find(selector, locator) }
  end

  # Gives a pretty name to RSpec when this is used in matchers.
  def inspect = self.class.name.underscore.tr("/_", " ")

  private

  attr_reader :page
end

class Example::NewPage < BasePage
  include Rails.application.routes.url_helpers

  def visit = page.visit(new_example_path)

  def form = @form ||= Form.new(page)

  class Form < BasePage
    def submit
      within_form do
        page.click_button("Create Example")
      end
    end

    def fill_in(with:)
      attributes = with

      within_form do
        attributes.each do |name, value|
          element = page.find(:id, "example_#{name}")

          if value == true || value == false
            element.set(value)
          else
            element.fill_in(with: value)
          end
        end
      end
    end

    private

    def within_form(&) = page.within('form[id$="example"]', &)
  end
end
