# RSpec Notification Formatter

The RSpec Notification Formatter is an RSpec formatter that shows a desktop
notification after the test suite has finished, if there are any failed
examples. It uses `osascript` under the hood so only macOS i supported.

## Requirements

* [RSpec](https://rspec.info)

## Usage

Run RSpec and require the full path of the snippet and specify the formatter:

```console
rspec -r <path/to/snippets/rspec_notification_formatter/snippet.rb> -f NotificationFormatter
```

Multiple formatters can be used at the same time:

```console
rspec -r <path/to/snippets/rspec_notification_formatter/snippet.rb> -f NotificationFormatter -f progress
```
