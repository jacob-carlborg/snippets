# This module allows to use Capybara helpers and matchers in view specs.
#
# This module sets up a simple Capybara session, a page and includes the Capybara
# DSL. With most of the Capybara helper and matchers available in view specs,
# it's now possible to pinpoint various HTML tags and CSS selectors just as in
# system and feature specs. A view spec is much more lightweight when it's
# enough to verify that specific content is present on the page and no
# interaction is required.
module CapybaraViewHelper
  include Capybara::DSL

  def self.included(mod)
    Capybara::Node::Simple.send(:define_method, :to_capybara_node) do
      self
    end
  end

  # This is a simpler version of {Capybara::Session}.
  #
  # It only includes {Capybara::Node::Finders}, {Capybara::Node::Matchers},
  # {#within} and {#within_element}. It is useful in that it does not require a
  # session, an application or a driver, but can still use Capybara's finders
  # and matchers on any string that contains HTML.
  #
  # Most of this code is shamelessly stolen from the {Capybara::Session} class
  # in the Capybara gem (https://github.com/teamcapybara/capybara/blob/e704d00879fb1d1e1a0cc01e04c101bcd8af4a68/lib/capybara/session.rb#L38).
  class SimpleSession
    # Stolen from: https://github.com/teamcapybara/capybara/blob/e704d00879fb1d1e1a0cc01e04c101bcd8af4a68/lib/capybara/session.rb#L767-L774.
    Capybara::Session::NODE_METHODS.each do |method|
      class_eval <<~METHOD, __FILE__, __LINE__ + 1
        def #{method}(...)
          current_scope.#{method}(...)
        end
      METHOD
    end

    # Initializes the receiver with the given string of HTML.
    #
    # @param html [String] the HTML to create the session out of
    def initialize(html)
      @document = Capybara::Node::Simple.new(Nokogiri::HTML.fragment(html))
    end

    def within(*args, **kw_args)
      new_scope = args.first.respond_to?(:to_capybara_node) ? args.first.to_capybara_node : find(*args, **kw_args)
      begin
        scopes.push(new_scope)
        yield if block_given?
      ensure
        scopes.pop
      end
    end
    alias_method :within_element, :within

    private

    attr_reader :document

    def scopes
      @scopes ||= [nil]
    end

    def current_scope
      scopes.last.presence || document
    end
  end

  def page
    content = respond_to?(:rendered_component) ? rendered_component : rendered
    @page ||= SimpleSession.new(content)
  end
end
