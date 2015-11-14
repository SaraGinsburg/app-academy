require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_line = params.keys
      .inject(""){ |str, key| str + "#{self.table_name}.#{key} = \"#{params[key]}\" AND "}
      .chomp(" AND ")

    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line}
    SQL

    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
