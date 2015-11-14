require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  @@table_name

  def self.columns
    # ...
    table = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    table.first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |column_name|
      define_method "#{column_name}" do
        attributes[column_name]
      end

      define_method "#{column_name}=" do |set_val|
        attributes[column_name] = set_val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    table = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL
    parse_all(table)
  end

  def self.parse_all(results)
    results.map do |result|
      self.new(result)
    end
  end

  def self.find(id)
    self.all.each{ |object| return object if object.id == id }
    nil
  end

  def initialize(params = {})
    params.each do |param, value|
      raise "unknown attribute '#{param}'" unless attributes.include?(param.to_sym)
      attributes[param.to_sym] = value
    end
  end

  def attributes
    new_attributes = {}
    self.class.columns.each do |column_name|
      new_attributes[column_name] = nil
    end

    @attributes ||= new_attributes
  end

  def attribute_values
    attributes.values
  end

  def sym_arr_to_sql_str(arr, to_delete, delim = "")
    sorted_cols = arr
    sorted_cols.delete(to_delete)
    sorted_cols.map(&:to_s)
      .inject(""){|str, item| str + delim + item + delim + ", "}
      .strip[0...-1]
  end

  def insert
    sorted_cols = self.class.columns.sort
    sorted_cols_str = sym_arr_to_sql_str(sorted_cols, :id)

    sorted_attr = attributes.keys.sort.map{|key| attributes[key]}
    sorted_attr_str = sym_arr_to_sql_str(sorted_attr, attributes[:id], "\"")

    DBConnection.execute(<<-SQL)
      INSERT INTO
        #{self.class.table_name} (#{sorted_cols_str})
      VALUES
        (#{sorted_attr_str})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    sorted_cols = self.class.columns.sort
    sorted_cols_str = sym_arr_to_sql_str(sorted_cols, :id)

    sorted_attr = attributes.keys.sort.map{|key| attributes[key]}
    sorted_attr_str = sym_arr_to_sql_str(sorted_attr, attributes[:id], "\"")

    sorted_attr_str_arr = sorted_attr_str.split(", ")

    set_str = ""
    sorted_cols.map(&:to_s).each_with_index do |val, idx|
      set_str << "#{val} = #{sorted_attr_str_arr[idx]}, "
    end
    set_str = set_str.strip[0...-1]

    DBConnection.execute(<<-SQL)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_str}
      WHERE
        id = #{self.id}
    SQL
  end

  def save
    self.class.find(self.id) ? self.update : self.insert
  end
end
