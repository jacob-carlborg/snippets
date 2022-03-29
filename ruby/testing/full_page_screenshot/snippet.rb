module FullPageScreenshotHelper
  # Takes a screenshot of the current page in the browser.
  #
  # This method is automatically called for system tests that fail.
  #
  # There seem to be no way of taking a screenshot of the whole web page. If
  # there is more to the page then is visual in the view port it won't be
  # included in the screenshot. This is workaround will:
  #
  # 1. Remove the overflow properties on the `main` element. This allows
  #     to get the full content height. This is site specific. If the site does
  #     not have overflow set, use the `body` tag instead of the `main` tag.
  # 2. Adjust the window size to the content size from the previous step
  def save_image
    main = page.execute_script <<~JAVASCRIPT
      const main = document.getElementsByTagName("main")[0]
      main.style.overflow = "visible"
      return main
    JAVASCRIPT

    width, height = main.size.width, main.size.height
    page.driver.browser.manage.window.resize_to(width, height)

    super
  end
end

module ActionDispatch
  module SystemTesting
    module TestHelpers
      module ScreenshotHelper
        prepend ::FullPageScreenshotHelper
      end
    end
  end
end
