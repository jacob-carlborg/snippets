# ActiveRecord Query Counter

This snippet counts ActiveRecord SQL queries.

## Requirements

* [Ruby on Rails](https://rubyonrails.org)

## Usage

1. Copy the snippet and paste it in a new file somewhere.
1. Count queries during the duration of a block:

    ```ruby
    class Foo < ActiveRecord::Base
    end

    QueryCounter.count_queries do |counter|
      puts counter.count # => 0
      Foo.last
      puts counter.count # => 1
    end
    ```
