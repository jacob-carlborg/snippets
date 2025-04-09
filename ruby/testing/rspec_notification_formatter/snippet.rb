class NotificationFormatter
  RSpec::Core::Formatters.register self, :dump_summary

  def initialize(...)
  end

  def dump_summary(summary)
    return if summary.failure_count.zero?
    summary_text = "#{summary.failure_count} failure(s)"
    `osascript -e 'display notification "#{summary_text}" with title "RSpec finished"'`
  end
end
