require 'sqlite3'

class Robot

  attr_reader :id,
              :name,
              :city,
              :state,
              :department

  def initialize(robot_params)
    @id                       = robot_params["id"] if robot_params["id"]
    @name                     = robot_params["name"]
    @city                     = robot_params["city"]
    @state                    = robot_params["state"]
    @department               = robot_params["department"]
    @database = SQLite3::Database.new('db/robot_world_development.db')
    @database.results_as_hash = true
  end

  def self.create(robot_params)
    new(robot_params)
  end

  def save
    @database.execute("INSERT INTO robots (name, city, state, department)
                       VALUES (?,?,?,?);",
                       @name, @city, @state, @department
                     )
  end

  def self.all
    robots = database.execute("SELECT * FROM robots")
    robots.map { |robot| Robot.new(robot)}
  end

  def self.find(id)
    robot = database.execute("SELECT * FROM robots WHERE id = ?;", id).first
    Robot.new(robot)
  end

  def self.database
    database = SQLite3::Database.new('db/robot_world_development.db')
    database.results_as_hash = true
    database
  end

end
