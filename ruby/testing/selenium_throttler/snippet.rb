module SeleniumThrottler
  def self.enable_throttling?
    ENV.key?("SELENIUM_THROTTLING")
  end

  def self.throttling_factor
    @throttling_factor ||= Float(ENV["SELENIUM_THROTTLING"])
  rescue ArgumentError
    0.5
  end

  def execute(...)
    super.tap { sleep SeleniumThrottler.throttling_factor }
  end
end

if SeleniumThrottler.enable_throttling?
  class Selenium::WebDriver::Remote::Bridge
    prepend SeleniumThrottler
  end
end
