require_relative("../db/sql_runner.rb")

class Owner

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO owners (name) VALUES ($1) RETURNING id;"
    values = [@name]
    result = SqlRunner.run(sql,values)
    @id = result.first()['id'].to_i
  end

  def update()
    sql = "UPDATE owners SET name = $1 WHERE id=$2"
    values = [@name,@id]
    SqlRunner.run(sql,values)
  end

  def delete()
    sql = "DELETE * FROM owners WHERE id=$1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM owners WHERE id=$1"
    values = [id]
    SqlRunner.run(sql,values)
  end

  def self.all()
    sql = "SELECT * FROM owners"
    result = SqlRunner.run(sql)
    return result.map{|x| Owner.new(x)}
  end

  def self.find_by_id(id)
    sql = 'SELECT * FROM owners WHERE id=$1'
    values = [id]
    result = SqlRunner.run(sql,values)
    return Owner.new(result.first)
  end

  def self.delete_all()
    sql = 'DELETE FROM owners'
    SqlRunner.run(sql)
  end

end
