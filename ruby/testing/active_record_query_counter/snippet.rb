class QueryCounter
  attr_reader :count

  def initialize
    @count = 0
  end

  def self.count_queries(&block)
    counter = new
    ActiveSupport::Notifications.subscribed(counter, "sql.active_record") do
      block.call(counter)
    end
  end

  def call(_name, _start, _finish, _message_id, values)
    return if skip_query?(values)
    self.count += 1
  end

  private

  IGNORED_QUERIES = [
    /^PRAGMA(?!(table_info))/,
    /^SELECT currval/,
    /^SELECT CAST/,
    /^SELECT @@IDENTITY/,
    /^SELECT @@ROWCOUNT/,
    /^SAVEPOINT/,
    /^ROLLBACK TO SAVEPOINT/,
    /^RELEASE SAVEPOINT/,
    /^SHOW max_identifier_length/
  ].freeze

  private_constant :IGNORED_QUERIES

  attr_writer :count

  def skip_query?(values)
    values[:name] == 'CACHE' || IGNORED_QUERIES.any? { values[:sql] =~ _1 }
  end
end
