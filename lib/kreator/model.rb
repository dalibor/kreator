class ConnectionAdapter
  def find(id, table_name)
    rows = execute("select * from #{table_name} where id = #{id} limit 1")
    columns = columns(table_name)

    map_columns_to_values(columns, rows.first)
  end

  def find_all(table_name)
    rows = execute("select * from #{table_name}")
    columns = columns(table_name)

    rows.map { |row| map_columns_to_values(columns, row) }
  end

  def columns(table_name)
    table_info(table_name).map { |info| info["name"] }
  end

  def map_columns_to_values(columns, values)
    Hash[columns.zip(values)]
  end
end

class SqliteAdapter < ConnectionAdapter
  def initialize
    config_location = File.expand_path('config/database.yml', KREATOR_ROOT)
    config = YAML.load_file(config_location)
    @db = SQLite3::Database.new(config['database'])
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
    name.downcase + "s"
  end
end


# require models
models_path = File.expand_path('app/models', KREATOR_ROOT)
Dir["#{models_path}/*.rb"].sort.each { |m| require m }
