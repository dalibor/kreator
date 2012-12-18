class ConnectionAdapter
  def find(id, table_name)
    rows = execute("select * from #{table_name} where id = #{id} limit 1")

    build_attributes(rows.first, table_name)
  end

  def find_all(table_name)
    rows = execute("select * from #{table_name}")

    rows.map { |row| build_attributes(row, table_name) }
  end

  def build_attributes(values, table_name)
    columns = columns(table_name)
    Hash[columns.zip(values)]
  end

  def columns(table_name)
    table_info(table_name).map { |info| info["name"] }
  end
end

class SqliteAdapter < ConnectionAdapter
  def initialize
    @db = SQLite3::Database.new(File.join(File.dirname(__FILE__), "../db/database.db"))
  end

  def execute(sql)
    @db.execute(sql)
  end

  def table_info(table)
    @db.table_info(table)
  end
end

class Model
  @@connection = SqliteAdapter.new

  def initialize(attributes)
    @attributes = attributes
  end

  def method_missing(name, *arg)
    name = name.to_s
    columns = @@connection.columns(self.class.table_name)

    if columns.include?(name)
      @attributes[name]
    else
      super
    end
  end

  def self.find(id)
    attributes = @@connection.find(id, table_name)
    new(attributes)
  end

  def self.all
    @@connection.find_all(table_name).map { |attributes| new(attributes) }
  end

  def self.table_name
    "#{name.downcase}s" # pluralize
  end
end
