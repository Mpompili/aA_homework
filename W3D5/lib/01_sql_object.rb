# require 'byebug'
require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    # class_name = self.class
    # answer = []
    unless @answer
      @answer = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL
    else
    end
    @answer.first.map(&:to_sym)

  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end
      define_method("#{column}=") do |ivar|
        self.attributes[column] = ivar
      end
    end
  end

  def self.table_name=(table_name)
      @table_name = table_name
  end

  def self.table_name
    @table_name || self.name.tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
    SELECT
      *
    FROM
      #{self.table_name}
    SQL
    self.parse_all(results)
  end

  def self.parse_all(results)
    results.map do |result|
      self.new(result)
    end
  end

  def self.find(id)
      a = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
      SQL
    self.parse_all(a).first
  end

  def initialize(params = {})
    params.each do |key, value|
      key = key.to_sym
      if self.class.columns.include?(key)
        self.send("#{key}=", value)
      else
        raise "unknown attribute '#{key}'"
      end
    end
  end

  def attributes
    if @attributes
      @attributes
    else
      @attributes = {}
    end
    # self.class.columns.each do |ivar|
    #   @attribute[ivar]
  end

  def attribute_values
    self.class.columns.map do |ivar|
      @attributes[ivar]
    end
  end

  def insert
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(", ")
    question_marks = (["?"] * columns.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
    INSERT INTO
      #{self.class.table_name} (#{col_names})
    VALUES
      (#{question_marks})
    SQL
    # a.id = last_insert_row_id
    # ...
    self.id = DBConnection.last_insert_row_id
  end

  def update
    col_name = self.class.columns.drop(1).map {|attr_name| "#{attr_name} = ?"}.join(', ')

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
    UPDATE
      #{self.class.table_name}
    SET
      #{col_name}
    WHERE
      id = #{attribute_values[0]}
    SQL
    # ...
  end

  def save
    self.id.nil? ? insert : update
  end
end
