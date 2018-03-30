require_relative("../db/sql_runner.rb")

class Owner

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id']
  end

  def save
    sql = "INSERT INTO owners (name) = "
  end

end
