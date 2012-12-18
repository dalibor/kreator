require "sqlite3"

file = File.expand_path('../database.db', __FILE__)

# Delete a file if already exists
File.delete(file) if File.exist?(file)

# Open a database
db = SQLite3::Database.new(file)

db.execute <<-SQL
  create table users (
    id int,
    name varchar(30)
  );
SQL

db.execute "insert into users values (?, ?)", [1, "Mille"]
db.execute "insert into users values (?, ?)", [2, "Ventor"]
db.execute "insert into users values (?, ?)", [3, "Speesy"]
db.execute "insert into users values (?, ?)", [4, "Sami"]

db.execute( "select * from users" ) { |row| p row }
